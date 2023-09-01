import os
import ast
import json
import yaml
import platform
import subprocess

from typing import Optional, List


def getWorkPath():
    workFilePath = os.path.abspath(__file__)
    workFileDirectory = os.path.dirname(workFilePath)
    return workFileDirectory


def getTargetPath(workPath: Optional[str], tarPath: str):
    if workPath is None:
        return os.path.join(getWorkPath(), tarPath)

    return os.path.join(workPath, tarPath)


def getRegionByCLI():

    command = "aws ec2 describe-regions --output yaml"
    commandList = command.split(' ')
    commandPrcs = subprocess.run(
        commandList, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    commandPrcsResult = yaml.safe_load(commandPrcs.stdout)
    return commandPrcsResult


def cvtRegionToList(commandPrcsResult: any):
    cvtRegionList = []

    for Region in commandPrcsResult['Regions']:
        regionName = Region['RegionName']
        cvtRegionList.append(regionName)

    return cvtRegionList


def runCommand(commandList: List[str], directory: str):
    process = subprocess.run(commandList, cwd=directory)
    processResult = process.stdout
    print(processResult)


class Result():
    tCount: int
    region: List[str]

    def __init__(self, regionList: List[str]) -> None:
        self.tCount = 0
        self.region = [{region: []} for region in regionList]

    def appendId(self, region: str, id: str) -> None:
        index: int = next(
            (i for i, d in enumerate(self.region) if region in d),
            -1
        )

        if index != -1:
            self.region[index][region].append(id)
            self.tCount += 1


class ResultWriter():

    ec2: Result
    ebs: Result

    def __init__(self, cvtRegionList: List[str]):
        self.cvtRegionList = cvtRegionList
        self.ec2 = Result(self.cvtRegionList)
        self.ebs = Result(self.cvtRegionList)

    def saveResult(self):
        data = {}
        for attr, value in vars(self).items():
            if isinstance(value, Result):
                data[attr] = vars(value)
            # 제거 금지
            # elif not callable(value) and not attr.startswith("__"):
            #     data[attr] = value
        print(data)
        with open('result.yml', 'w') as yamlFile:
            yaml.dump(data, yamlFile, default_flow_style=False)


class ProcessConverter():

    def __init__(self, completedProcess: subprocess.CompletedProcess) -> None:
        self.completedProcess = completedProcess

    def cvtToEC2List(self):
        processStdout = self.completedProcess.stdout.decode('utf-8')
        processStdout = processStdout.replace('instance_ids = ', '')
        processStdout = processStdout.replace(' =', ':')
        processStdout = processStdout.replace('\\"', '')
        processStdout = '\n'.join(
            line + ',' if line.strip().endswith('"') else line for line in processStdout.split('\n'))

        ec2List = ast.literal_eval(processStdout)
        return ec2List

    def cvtToEBSList(self):
        return self.cvtToEC2List()


if __name__ == '__main__':

    osType = platform.system()
    initDirectory = getWorkPath()

    targetList = ['ec2', 'ebs']
    commandPrcsResult = getRegionByCLI()
    cvtRegionList = cvtRegionToList(commandPrcsResult=commandPrcsResult)
    # cvtRegionList = ['ap-northeast-2']

    resultWriter = ResultWriter(cvtRegionList)

    for target in targetList:

        directory = getTargetPath(workPath=initDirectory, tarPath=target)
        for cvtRegion in cvtRegionList:
            print(target, cvtRegion, directory)

            applyCommand = f'terraform apply -var "region_name={cvtRegion}" --auto-approve'
            applyCommand += ' > NUL' if osType == 'Windows' else '1> /dev/null'
            outputCommand = ['terraform', 'output', 'instance_ids']

            os.chdir(directory)
            os.system(applyCommand)

            process = subprocess.run(
                outputCommand,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
            )
            processConverter = ProcessConverter(process)
            if target == 'ec2':
                ec2IdList = processConverter.cvtToEC2List()
                for ec2Id in ec2IdList:
                    resultWriter.ec2.appendId(region=cvtRegion, id=ec2Id)

            if target == 'ebs':
                ebsIdList = processConverter.cvtToEBSList()
                for ebsId in ebsIdList:
                    resultWriter.ebs.appendId(region=cvtRegion, id=ebsId)

            else:
                ec2IdList = []
    os.chdir(initDirectory)
    resultWriter.saveResult()

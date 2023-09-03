import os
import ast
import json
import yaml
import platform
import subprocess

from typing import Optional, List
from s3.get_s3_data import getS3List
from eip.get_eip_data import getEipList
from elb.get_elb_list import getClbList, getElbList
from rds.get_rds_list import getRdsList
from ec2_keypair.get_ec2_keypair_list import getEc2KeyPairList


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

    s3: Result
    ec2_keypair: Result
    eip: Result
    clb: Result
    elb: Result
    rds: Result

    def __init__(self, cvtRegionList: List[str]):
        # With Terraform
        self.cvtRegionList = cvtRegionList
        self.ec2 = Result(self.cvtRegionList)
        self.ebs = Result(self.cvtRegionList)

        # With AWS CLI

        tmpS3RegionList = self.cvtRegionList.copy()
        tmpS3RegionList.extend(['null'])
        self.s3 = Result(tmpS3RegionList)

        self.eip = Result(self.cvtRegionList)
        self.clb = Result(self.cvtRegionList)
        self.elb = Result(self.cvtRegionList)
        self.ec2_keypair = Result(self.cvtRegionList)

        self.rds = Result(self.cvtRegionList)

    def saveResult(self):
        data = {}
        for attr, value in vars(self).items():
            if isinstance(value, Result):
                data[attr] = vars(value)
            # 제거 금지
            # elif not callable(value) and not attr.startswith("__"):
            #     data[attr] = value
        print(getCurrTime(), data)
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
        print(ec2List)
        return ec2List

    def cvtToEBSList(self):
        return self.cvtToEC2List()


def getCurrTime():
    from datetime import datetime

    # Get the current time and format it
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M")
    return current_time


if __name__ == '__main__':

    osType = platform.system()
    initDirectory = getWorkPath()

    terraformList = ['ec2', 'ebs', 's3', 'eip', 'elb', 'rds', 'ec2-keypair']
    # terraformList = ['s3', 'eip', 'elb', 'rds', 'ec2-keypair'] ### RESTRICT! ###
    awsCliList = ['s3', 'eip', 'elb', 'rds', 'ec2-keypair']

    commandPrcsResult = getRegionByCLI()
    cvtRegionList = cvtRegionToList(commandPrcsResult=commandPrcsResult)
    cvtRegionList = ['us-east-1', 'ap-northeast-2']  # RESTRICT! ###

    resultWriter = ResultWriter(cvtRegionList)

    for target in terraformList:

        directory = getTargetPath(workPath=initDirectory, tarPath=target)
        for cvtRegion in cvtRegionList:

            if target in awsCliList:

                if target == 's3':
                    s3List = getS3List()
                    for s3 in s3List:
                        bucketRegion, bucketData = s3
                        resultWriter.s3.appendId(
                            region=bucketRegion,
                            id=bucketData
                        )

                if target == 'eip':
                    eipList = getEipList(cvtRegionList)
                    for eip in eipList:
                        bucketRegion, bucketData = eip
                        resultWriter.eip.appendId(
                            region=bucketRegion,
                            id=bucketData
                        )

                if target == 'elb':
                    clbList = getClbList(cvtRegionList)
                    elbList = getElbList(cvtRegionList)
                    for clb in clbList:
                        bucketRegion, bucketData = clb
                        resultWriter.clb.appendId(
                            region=bucketRegion,
                            id=bucketData
                        )
                    for elb in elbList:
                        bucketRegion, bucketData = elb
                        resultWriter.elb.appendId(
                            region=bucketRegion,
                            id=bucketData
                        )
                if target == 'rds':
                    rdsList = getRdsList(cvtRegionList)
                    for rds in rdsList:
                        bucketRegion, bucketData = rds
                        resultWriter.rds.appendId(
                            region=bucketRegion,
                            id=bucketData
                        )
                if target == 'ec2-keypair':
                    ec2KeyPairList = getEc2KeyPairList(cvtRegionList)
                    for ec2KeyPair in ec2KeyPairList:
                        bucketRegion, data = ec2KeyPair
                        resultWriter.ec2_keypair.appendId(
                            region=bucketRegion,
                            id=data
                        )
            else:

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

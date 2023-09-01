# EIB 정보를 Terraform을 통해서 가져올 수 없어서 우회하는 방식을 선택했습니다.
import os
import json
import subprocess

from typing import List, Tuple


def getRdsList(regionList: List[str]):

    eipList = []

    for region in regionList:

        command = f'aws rds describe-db-instances --region {region} --query DBInstances[*].DBInstanceIdentifier --profile edint-prac-root'
        spltCommand = command.split(' ')
        process = subprocess.run(
            spltCommand,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        processSdtout = process.stdout.decode('utf-8')
        processSdtout = json.loads(processSdtout)

        eipList.append((region, {'rdsList': processSdtout},))

    return eipList


if __name__ == '__main__':
    rdsList = getRdsList(['us-east-1', 'ap-northeast-2'])
    print(rdsList)

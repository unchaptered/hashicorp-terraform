# EIB 정보를 Terraform을 통해서 가져올 수 없어서 우회하는 방식을 선택했습니다.
import os
import json
import subprocess

from typing import List, Tuple


def getEipList(regionList: List[str]):

    eipList = []
    for region in regionList:
        command = f'aws ec2 describe-addresses --region {region} --query Addresses[*].PublicIp --profile edint-prac-root'
        spltCommand = command.split(' ')
        process = subprocess.run(
            spltCommand,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        processSdtout = process.stdout.decode('utf-8')
        processSdtout = json.loads(processSdtout)

        eipList.append((region, {'eipList': processSdtout},))

    return eipList


if __name__ == '__main__':
    eip = getEipList(['us-east-1', 'ap-northeast-2'])
    print(eip)

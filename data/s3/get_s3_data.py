# S3는 Terraform을 통해서 가져올 수 없어서 우회하는 방식을 선택했습니다.
import os
import subprocess

from typing import List, Tuple


def getS3RegionByS3(bucketName: str):
    command = f'aws s3api get-bucket-location --bucket {bucketName} --query "LocationConstraint" --profile edint-prac-root'
    spltCommand = command.split(' ')
    process = subprocess.run(
        spltCommand,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    processStdout = process.stdout.decode('utf-8')
    processStdout.splitlines()

    bucketRegion = processStdout.splitlines()[0]
    bucketRegion = bucketRegion.replace('\"', '')

    return bucketRegion


def getS3List() -> List[Tuple[str, dict]]:
    command = 'aws s3 ls --profile edint-prac-root'
    spltCommand = command.split(' ')
    process = subprocess.run(
        spltCommand,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    processStdout = process.stdout.decode('utf-8')
    processStdoutLines = processStdout.splitlines()

    fmtPSLine = []
    for pSline in processStdoutLines:
        date, time, bucketName = pSline.split(' ')
        bucketRegion = getS3RegionByS3(bucketName)

        fmtPSLine.append((bucketRegion, {'bucketName': bucketName},))

    return fmtPSLine


if __name__ == '__main__':
    res = getS3List()
    print(res)

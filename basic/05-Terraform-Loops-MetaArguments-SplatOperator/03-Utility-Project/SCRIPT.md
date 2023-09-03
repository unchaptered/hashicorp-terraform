다음 스크립트로 t2.micro 가 지원되는 리전을 볼 수 있습니다.

```cmd
aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t2.micro --region ap-northeast-2 --output table
```
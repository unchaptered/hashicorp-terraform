# Null 리소스와 Provisioners 생성
resource "null_resource" "name" {

    depends_on = [ module.ec2_public]
    # Connection 블록: 리소스 Provisioners가 EC2 인스턴스에 연결할 수 있도록 설정
    connection {
        type = "ssh"
        host = aws_eip.bastion_eip.public_ip
        user = "ec2-user"
        password = ""
        private_key = file("private-key/terraform-key.pem")
    }

    ## File Provisioner : terraform-key.pem 파일을 /tmp/terraform-key.pem으로 복사
    provisioner "file" {
        source      = "private-key/terraform-key.pem"
        destination = "/tmp/terraform-key.pem"
    }

    ## Remote Exec Provisioner: remote-exec provisioner를 사용하여 Bastion Host의 private key 권한을 수정
    provisioner "remote-exec" {
        inline  = [
            "sudo chmod 400 /tmp/terraform-key.pem"
        ]
    }

    ## Local Exec Provisioner: local-exec provisioner (Creation-Time Provisioner - 리소스 생성시 트리거됨)
    provisioner "local-exec" {
        command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
        working_dir = "local-exec-output-files/"
        # on_failure = continue
    }
    
    ## Local Exec Provisioner: local-exec provisioner (Destroy-Time Provisioner - 리소스 삭제시 트리거됨)
    # provisioner "local-exec" {
    #     command     = "echo Destroy time prov `data` >> destroy-time-prov.txt"
    #     working_dir = "local-exec-output-files/"
    #     when        = destroy
    #     # on_failure = continue
    # }
    
    # Creation Time Provisioners - 리소스 생성시 자동으로 생성됨 (terraform apply)
    # Destroy Time Provisioners - "terraform destroy" 명령어 실행시 자동으로 실행됨 (when = destroy)
}

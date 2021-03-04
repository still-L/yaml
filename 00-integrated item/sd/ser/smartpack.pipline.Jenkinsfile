pipeline {
    agent any
    tools {
        maven 'maven-3.6.3'
        jdk 'JDK8'
    }
    environment {
        version = "$BUILD_NUMBER"
    }
    stages {
        stage('检出代码') {
            steps {
                echo '=========checkout..=========='
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'c84eb849-9efe-46f1-a6d1-cea6955e4415', url: 'git@gitlab.lenovo.com:zhangbao2/smartpacking.git']]])
            }
        }
        stage('maven build'){
            steps{
                echo '======build======='
                sh 'mvn clean && mvn install'
                sh 'cd target/ && unzip smartPack-customAssembly.zip'
            }
        }
        stage('构建镜像Docker build&&push') {
            steps {
                echo 'Docker build....'
                sh("docker build -f smartpack.dockerfile -t harbor.aipo.lenovo.com/smartdata/smartpack-ser:$version .")
                sh("docker push harbor.aipo.lenovo.com/smartdata/smartpack-ser:$version")
            }
        }
        stage('Deploy k8s') {
            steps {
                echo 'kubectl run'
                sh("sed -i -e 's/\$version/$version/g' smartpack.yaml")
                sh("kubectl apply -f smartpack.yaml")
            }
        }
        stage('change smartpack.yaml env') {
            steps {
                echo 'change smartpack.yaml env'
                sh ('sed -i "s/\$version/\\\$version/g" smartpack.yaml')
            }
        }
    }
}
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
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'c84eb849-9efe-46f1-a6d1-cea6955e4415', url: 'git@gitlab.lenovo.com:AI/ai-dps-web.git']]])
            }
        }
        stage('build..'){
            steps{
                echo '======build======='
                //sh 'mvn clean && mvn install'
                sh 'mvn compile'
            }
        }
        stage('构建镜像Docker build&&push') {
            steps {
                echo 'Docker build....'
                sh("docker build -f ams.dockerfile -t harbor.aipo.lenovo.com/po-ams/po-ams-ser:$version .")
                sh("docker push harbor.aipo.lenovo.com/po-ams/po-ams-ser:$version")
            }
        }
        stage('Deploy k8s') {
            steps {
                echo 'kubectl run'
                sh("sed -i -e 's/\$version/$version/g' po-ams-ser.yaml")
                sh("kubectl apply -f po-ams-ser.yaml")
            }
        }
        stage('change po-ams-ser.yaml env') {
            steps {
                echo 'change po-ams-ser.yaml env'
                sh ('sed -i "s/\$version/\\\$version/g" po-ams-ser.yaml')
            }
        }
    }
}
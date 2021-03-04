pipeline {
    agent any
    tools {
        nodejs 'NodeJS_14.3.0'
    }
    environment {
        version = "$BUILD_NUMBER"
    }
    stages {
        stage('检出代码') {
            steps {
                echo '=========checkout..=========='
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'c84eb849-9efe-46f1-a6d1-cea6955e4415', url: 'git@gitlab.lenovo.com:lihx23/dist-admin.git']]])
            }
        }
        stage('build..'){
            steps{
                echo '======build======='
                sh 'npm run build'
            }
        }
        stage('构建镜像Docker build&&push') {
            steps {
                echo 'Docker build....'
                sh("docker build -f web.dockerfile -t harbor.aipo.lenovo.com/po-ams/po-ams-web:$version .")
                sh("docker push harbor.aipo.lenovo.com/po-ams/po-ams-web:$version")
            }
        }
        stage('Deploy k8s') {
            steps {
                echo 'kubectl run'
                sh("sed -i -e 's/\$version/$version/g' po-ams-web.yaml")
                sh("kubectl apply -f po-ams-web.yaml")
            }
        }
        stage('change po-ams-web.yaml env') {
            steps {
                echo 'change po-ams-web.yaml env'
                sh ('sed -i "s/\$version/\\\$version/g" po-ams-web.yaml')
            }
        }
    }
}
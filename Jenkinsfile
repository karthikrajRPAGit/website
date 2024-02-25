pipeline {
    agent none
    environment {
	DOCKERHUB_CREDENTIALS = credentials('docker')
    }
    stages {
        stage('Build Docker Image') {
	   agent { label('node1 && node2') }
	   steps {
		echo "Inside Build"
		echo "Branch Name: ${env.GIT_BRANCH}"
		echo "Branch Short Name: ${env.GIT_BRANCH}.split('/')[1]"
		script {
			def branch=env.GIT_BRANCH.split("/")[1]
			if ((branch == "master") || (branch == "develop"))
				sh "docker build -t dockthik/intel-assess-devops-proj1:${env.BUILD_NUMBER} ."
		}
	   }
	}
        stage('Testing the succesful build of Docker Image') {
           agent { label('node1 && node2') }
           steps {
                script {
			def branch=env.GIT_BRANCH.split("/")[1]
                        if ((branch == "master") || (branch == "develop"))
                                sh "./run_test.sh"
                }
           }
        }
        stage('pushing docker Image to the Dockerhub and run the container') {
           agent { label('node2') }
           steps {
                script {
                        if (branch == "master")
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                                sh "docker tag dockthik/intel-assess-devops-proj1:${env.BUILD_NUMBER} dockthik/intel-assess-devops-proj1:latest"
				sh "docker push dockthik/intel-assess-devops-proj1:latest"
				sh "docker run -itd -p 81:80 dockthik/intel-assess-devops-proj1:latest" 
                }
           }
        }
   }
}

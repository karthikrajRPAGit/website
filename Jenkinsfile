pipeline {
    agent none
    environment {
	DOCKERHUB_CREDENTIALS = credentials('docker')
    }
    stages {
        stage('Build Docker Image') {
	   agent { label 'test' }
	   steps {
		echo "Inside Build of Test Node"
		echo "Branch Name: ${env.GIT_BRANCH}"
		script {
			def branch=env.GIT_BRANCH.split("/")[1]
			echo "${branch}"
			if ((branch == "master") || (branch == "develop"))
				sh "sudo docker build -t dockthik/intel-assess-devops-proj1:${env.BUILD_NUMBER} ."
		}
	   }
	}
        stage('Testing the succesful build of Docker Image') {
           agent { label 'test' }
           steps {
		echo "Inside Testing of the Test Node"
                script {
			def branch=env.GIT_BRANCH.split("/")[1]
                        if ((branch == "master") || (branch == "develop"))
                                sh "sudo sh ./run_test.sh ${env.BUILD_NUMBER}"
                }
           }
        }
        stage('pushing docker Image to the Dockerhub and run the container') {
           agent { label 'prod' }
           steps {
		echo "Pushing to dockerhub and running the container is done, only if its the push from Master branch"
                script {
			def branch=env.GIT_BRANCH.split("/")[1]
			echo "${branch}"
                        if (branch == "master")
			{
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                                sh "sudo docker tag dockthik/intel-assess-devops-proj1:${env.BUILD_NUMBER} dockthik/intel-assess-devops-proj1:latest"
				sh "sudo docker push dockthik/intel-assess-devops-proj1:latest"
				sh "sudo docker run -itd -p 81:80 dockthik/intel-assess-devops-proj1:latest"
			}
			else
			{
				echo "Push not from Master branch. So, Skipping this Step" 
			}
                }
           }
        }
   }
}

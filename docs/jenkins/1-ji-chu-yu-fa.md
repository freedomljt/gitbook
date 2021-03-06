# 基础语法

[参考文档](https://www.xncoding.com/2017/03/22/fullstack/jenkins02.html)

```javascript
// declarative
pipeline {
    agent any ①

    stages {
        stage('Build') { ②
            steps { ③
                sh 'make' ④
            }
        }
        stage('Test') {
            steps {
                sh 'make test'
                junit 'resports/**/*.xml' ⑤
            }
        }
        stage('Deploy') {
            steps {
                sh 'make deploy'
            }
        }
    }
}

// script
node {
    stage('Build') {
        sh 'make'
    }
    stage('Test') {
        sh 'make test'
        junit 'resports/**/*.xml'
    }
    stage('Deploy') {
        sh 'make deploy'
    }
}
```

* ① agent 指示jenkins分配一个执行器和工作空间来执行下面的pipeline
* ② stage表示这个pipeline的一个执行阶段
* ③ steps表示在这个stage中的每一个步骤
* ④ sh 执行指定的命令
* ⑤ junit是插件junit\[JUnit plugin\]提供的一个步骤，用来收集测试报告

## 使用多个agent

```javascript
pipeline {
    anget none
    stages {
        stage('Build') {
            agent any
            steps {
                checkout scm
                sh 'make'
            }
        }
        stage('Test dev') {
            agent {
                label 'worker'
            }
            steps {
                sh 'make'
            }
        }
        stage('Test production') {
            agent {
                label 'production'
            }
            steps {
                sh 'make'
            }
        }
    }
}
```

## 一些demo写法

[参考文档](https://www.theguild.nl/jenkinsfiles-for-beginners-and-masochists/)

```javascript
def withDockerNetwork(Closure inner) {
  try {
    networkId = UUID.randomUUID().toString()
    sh "docker network create ${networkId}"
    inner.call(networkId)
  } finally {
    sh "docker network rm ${networkId}"
  }
}

pipeline {
  agent none

  stages {
    stage("test") {
      agent any

      steps {
        script {
          def database = docker.build("database", "database")
          def app = docker.build("app", "-f dockerfiles/ci/Dockerfile .")

          withDockerNetwork{ n ->
            database.withRun("--network ${n} --name database") { c ->
              app.inside("""
                --network ${n}
                -e 'SPRING_DATASOURCE_URL=jdbc:postgresql://database:5432/test'
              """) {
                sh "mvn verify"
              }
            }
          }
        }
      }
    }
  }
}
```


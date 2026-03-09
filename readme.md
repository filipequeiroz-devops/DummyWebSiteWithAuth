# Aws cognito for website authentification

**Language / Idioma**: [🇺🇸 English](#-project-overview) | [🇧🇷 Português](#-visão-geral-do-projeto)

<div align="center">

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
![Amazon CloudFront](https://img.shields.io/badge/Amazon%20CloudFront-FF9900?style=for-the-badge&logo=amazoncloudfront&logoColor=white)
![Amazon API Gateway](https://img.shields.io/badge/Amazon%20API%20Gateway-FF4F8B?style=for-the-badge&logo=amazonapigateway&logoColor=white)
![AWS Lambda](https://img.shields.io/badge/AWS%20Lambda-FF9900?style=for-the-badge&logo=awslambda&logoColor=white)
![Amazon Cognito](https://img.shields.io/badge/Amazon%20Cognito-DD344C?style=for-the-badge&logo=amazoncognito&logoColor=white)
![PowerShell](https://img.shields.io/badge/powershell-2C2D72?style=for-the-badge&logo=powershell&logoColor=white)
![Amazon S3](https://img.shields.io/badge/Amazon%20S3-569A31?style=for-the-badge&logo=amazons3&logoColor=white) 

</div>
---

## 🇺🇸 Project Overview

This project implements a secure **Serverless Authentication Architecture** designed for high scalability and cost-efficiency. It focuses on identity management using **AWS Cognito** and infrastructure protection through **API Gateway Authorizers** and **Terraform**.

### 🏗️ Architecture & Security Workflow

1.  **Identity Management:** Utilizes **AWS Cognito User Pools** for secure user registration, confirmation (Email verification code), and authentication.
2.  **API Security:** Implemented a **JWT (JSON Web Token) Authorizer** at the **API Gateway** level to protect backend resources.
3.  **State Management:** Secure handling of authentication tokens using browser **LocalStorage** with **JavaScript Route Guards** to prevent unauthorized access to restricted UI sections.
4.  **Infrastructure as Code (IaC):** 100% of the cloud environment (Cognito, API Gateway, Lambdas, and Networking) is provisioned and managed via **Terraform**.
5.  **CORS & Networking:** configuration of **CORS (Cross-Origin Resource Sharing)** and **Preflight (OPTIONS)** requests to ensure secure communication between the S3-hosted frontend and the API.

If you like to see it working, pleass acess http://randombucket-2026-filipe.s3-website-us-east-1.amazonaws.com
---

## 🇧🇷 Visão Geral do Projeto

Este projeto implementa uma **Arquitetura de Autenticação Serverless** segura, projetada para alta escalabilidade e baixo custo. O foco principal é a gestão de identidade usando **AWS Cognito** e a proteção de infraestrutura através de **Authorizers no API Gateway** e **Terraform**.

### 🏗️ Arquitetura e Fluxo de Segurança

1.  **Gestão de Identidade:** Utiliza **AWS Cognito User Pools** para registro seguro de usuários, confirmação via código e autenticação.
2.  **Segurança de API:** Implementação de um **Authorizer JWT (JSON Web Token)** no **API Gateway** para proteger recursos de backend de acessos não autorizados.
3.  **Gestão de Estado:** Manipulação segura de tokens de autenticação via **LocalStorage** e **Route Guards** em JavaScript para proteger rotas sensíveis no frontend.
4.  **Infraestrutura como Código (IaC):** Todo o ambiente cloud (Cognito, API Gateway, Lambdas e Redes) é provisionado e gerenciado via **Terraform**.
5.  **CORS e Redes:** Configuração avançada de políticas de **CORS** e requisições **Preflight (OPTIONS)** para permitir a comunicação segura entre o frontend (S3) e os endpoints da API.

---

### 🚀 Tech Stack

* **Cloud:** AWS (Cognito, API Gateway, Lambda, S3).
* **IaC:** Terraform.
* **Language:** Python (Backend/Lambda) and JavaScript (Frontend/Logic).
* **CI/CD:** GitHub Actions for automated deployment.

---

<div align="center">
  <sub>Developed by **Filipe Queiroz** as part of a DevOps & SRE Career Transition Portfolio.</sub>
</div>
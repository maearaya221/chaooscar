# Infraestructura Modular con Terraform

Este proyecto organiza la infraestructura utilizando **módulos de Terraform**, lo que permite:

- **Estandarización** de recursos.
- **Reutilización de código** entre diferentes entornos.
- **Mantenimiento simplificado** y fácil escalabilidad.

## Estructura de Carpetas

```plaintext
environments/
└── infraestructura/
    ├── main.tf
    ├── terraform.tfvars
    └── variables.tf

modules/
├── ec2_instance/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── ami/
├── auto_scaling/
├── ec2_instance/
|── internet_gateway/
|── key/
|── listener/
|── load_balancer/
|── nat_gateway/
|── security_group/
|── subnets/
|── target_group/
|── vpc/

- **environments/** → Contiene la definición principal del entorno que orquesta todos los módulos.
- **modules/** → Contiene los módulos reutilizables para distintos recursos (EC2, VPC, balanceadores, etc.).


-**Cómo Iniciar**

1. Inicializar Terraform:
   ```bash
   terraform init
   ```

2. Validar la configuración:
   ```bash
   terraform validate
   ```

3. Planificar los cambios:
   ```bash
   terraform plan
   ```

4. Aplicar la infraestructura:
   ```bash
   terraform apply -auto-approve
   ```
5. Destruir la infraestructura:
   ```bash
   terraform destroy -auto-approve
   ```




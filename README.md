#LAB 05 INTEGRACION DE AEW Y LAMBDA
El propósito de este proyecto es implementar una arquitectura **Serverless en AWS**, administrada completamente con Terraform.  
La infraestructura permite automatizar el despliegue y gestión de servicios en la nube, facilitando la escalabilidad y el mantenimiento del sistema. Uzando los entornos dev, prod y qa.

Los principales recursos utilizados son:

- AWS Lambda
- NAT Gateway
- API Gateway
- Terraform Workspaces
- Configuración de red y permisos necesarios

---

## Estructura del Proyecto

```bash
terraform/
````

Contiene los archivos de configuración de Terraform (`.tf`) encargados de crear la infraestructura.

```bash
src/
```

Incluye el código fuente de las funciones Lambda y los recursos utilizados por estas.

```bash
terraform.tfstate.d/
```

Directorio generado automáticamente por Terraform para almacenar el estado de los diferentes entornos o workspaces.

---

## Entornos de Despliegue

El proyecto está preparado para trabajar con múltiples entornos mediante Terraform Workspaces:

* `dev` → Entorno de desarrollo
* `qa` → Entorno de pruebas y validación
* `prod` → Entorno de producción

---

## Prerrequisitos

Antes de ejecutar el proyecto, asegúrate de tener instalado y configurado lo siguiente:

* Terraform
* AWS CLI
* Credenciales de AWS configuradas correctamente

---

# Despliegue del Proyecto

## 1. Inicializar Terraform

Ubícate en la carpeta donde se encuentran los archivos Terraform y ejecuta:

```bash
cd terraform
terraform init
```

---

## 2. Seleccionar el Workspace

Selecciona el entorno donde deseas desplegar la infraestructura.

### Desarrollo

```bash
terraform workspace select dev
```

Si el workspace aún no existe:

```bash
terraform workspace new dev
```

### Otros entornos

```bash
terraform workspace select qa
```

```bash
terraform workspace select prod
```

---

## 3. Verificar el Plan de Ejecución

Antes de aplicar cambios, revisa los recursos que Terraform creará o modificará:

```bash
terraform plan
```

---

## 4. Desplegar la Infraestructura

Ejecuta el siguiente comando para crear la infraestructura en AWS:

```bash
terraform apply
```

Terraform solicitará confirmación antes de aplicar los cambios.

---

# Prueba de la API

Una vez finalizado el despliegue, Terraform mostrará el endpoint del API Gateway.

Puedes realizar una petición POST usando:

```bash
curl.exe -X POST https://9w78syf0d9.execute-api.us-east-1.amazonaws.com/upload \
  -H "Content-Type: image/jpeg" \
  --data-binary "@photo.jpg"
```

---

# Eliminar la Infraestructura

Si deseas eliminar todos los recursos creados en un entorno específico:

```bash
terraform destroy
```

Asegúrate de encontrarte en el workspace correcto antes de ejecutar el comando.

---

## Autor

Proyecto desarrollado por Mayli Centa Fernandez.

```


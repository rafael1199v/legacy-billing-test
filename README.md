# Legacy Billing System - Evaluación de Cloud Computing

Este repositorio contiene la solución completa para la evaluación de infraestructura en la nube, abarcando Integración Continua (CI), Infraestructura como Código (IaC) modular y Despliegue Continuo (CD) mediante GitOps en AWS.

---

## Validación en Vivo

La aplicación "Facturación y Finanzas (Legacy)" se encuentra desplegada y respondiendo en el entorno de producción.

*   **URL de Acceso:** [http://3.236.131.33:3000/](http://3.236.131.33:3000/)

> **AVISO IMPORTANTE DE SEGURIDAD PARA EL DOCENTE**
> Cumpliendo estrictamente con el requerimiento de Ciberseguridad del **Hito 3** (Restricción de Red), el Security Group actual (`sg_aplicacion_nodejs`) está configurado para rechazar tráfico general (`0.0.0.0/0`) y **solo permite conexiones entrantes desde la IP pública autorizada del alumno (/32)**.
> 
> **Para realizar la validación en vivo de la URL:**
> Por favor, proporcione su dirección IP pública para que sea añadida dinámicamente al archivo `variables.tf` a través del pipeline de GitOps, o en su defecto, confirme la autorización para realizar una apertura temporal del puerto 3000.

---

## 🏗️ Arquitectura CI/CD Implementada

El proyecto sigue una filosofía GitOps estructurada en tres pilares fundamentales, garantizando que todo cambio en la infraestructura o el código pase por un proceso estricto de validación y despliegue automatizado.

### 1. Integración Continua (CI) - Hito 1
Implementado mediante GitHub Actions (`.github/workflows/ci.yml`), este pipeline vigila la rama `develop`.
*   **Entorno:** Ubuntu Latest con Node.js v20 (LTS).
*   **Comportamiento:** Ante cualquier `push` o `pull_request`, instala las dependencias y ejecuta las pruebas unitarias (`npm test`).
*   **Seguridad de Pase:** Actúa como *Quality Gate*. Si la prueba de cálculo de impuestos falla, el pipeline se aborta. Si es exitosa, empaqueta el código limpio (excluyendo metadatos de Git) y expone el artefacto para su descarga o pase a producción.

### 2. Infraestructura como Código (IaC) - Hito 2
Desarrollada utilizando **Terraform** con una arquitectura fuertemente modular, evitando monolitos y valores hardcodeados.
*   **Backend Remoto:** El estado (`.tfstate`) se almacena de forma segura en el bucket S3 `rafael-vargas-examen-cloud`, resolviendo el problema de dependencia circular mediante su creación previa en consola.
*   **Módulo de Red (`network`):** Gestiona los Security Groups parametrizados, inyectando la IP permitida y el puerto de la aplicación como variables globales.
*   **Módulo de Cómputo (`compute`):** Aprovisiona la instancia EC2 utilizando Amazon Linux 2023. Implementa el gestor de paquetes `dnf` dentro del `user_data` para automatizar la instalación de dependencias (Node.js, Git) y el arranque de la aplicación.

### 3. Despliegue Continuo (CD) e Imprevisto - Hito 3
Implementado en `.github/workflows/cd.yml`, este pipeline gobierna la rama `main` y es el único autorizado para modificar AWS.
*   **Gestión de Secretos:** Utiliza el entorno `deployment` de GitHub para inyectar de forma segura las credenciales temporales de AWS Academy (Access Key, Secret Key y Session Token).
*   **Ejecución GitOps:** Instala Terraform CLI (v1.6+) y ejecuta automáticamente la secuencia `init`, `plan` y `apply -auto-approve`.
*   **Resolución de Imprevistos:** A través de este flujo, se demostró la capacidad de escalar verticalmente la infraestructura (de `t2.micro` a `t3.micro`) y aplicar parches de seguridad de red en cuestión de minutos, con cero intervención manual en la consola de AWS.
*   **Recreación Forzada:** Se implementó `user_data_replace_on_change = true` para garantizar que las actualizaciones en el script de arranque generen servidores inmutables y limpios en cada despliegue.

---

*Evaluación desarrollada para la materia de Computación en la Nube.*
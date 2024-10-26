import subprocess

def ejecutar_comando_git():
    try:
        # Primero realizar git pull para obtener cambios remotos
        print("Obteniendo cambios del repositorio remoto...")
        subprocess.run(["git", "pull"], check=True)
        print("Pull realizado exitosamente.")

        # Verificar si hay cambios para commit
        status = subprocess.run(["git", "status", "--porcelain"], 
                              capture_output=True, 
                              text=True, 
                              check=True)
        
        if not status.stdout.strip():
            print("No hay cambios para commit.")
            return

        # Agregar todos los cambios
        subprocess.run(["git", "add", "."], check=True)
        print("Archivos añadidos exitosamente.")

        # Hacer commit con el mensaje personalizado o default
        commit_message = input("Introduce el mensaje del commit (Enter para 'cambios'): ") or "cambios"
        subprocess.run(["git", "commit", "-m", commit_message], check=True)
        print(f"Commit realizado con el mensaje: '{commit_message}'")

        # Hacer push
        print("Subiendo cambios al repositorio remoto...")
        subprocess.run(["git", "push"], check=True)
        print("Push realizado exitosamente.")

    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar comando git: {e}")
        # Mostrar el error específico si está disponible
        if e.stderr:
            print(f"Detalles del error: {e.stderr.decode() if isinstance(e.stderr, bytes) else e.stderr}")
    except Exception as e:
        print(f"Error inesperado: {e}")

if __name__ == "__main__":
    ejecutar_comando_git()
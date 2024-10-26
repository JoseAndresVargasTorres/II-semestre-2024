import subprocess

def ejecutar_comando_git():
    try:
        # Agregar todos los cambios
        subprocess.run(["git", "add", "."], check=True)
        print("Archivos añadidos exitosamente.")

        # Hacer commit con el mensaje "cambios"
        commit_message = input("Introduce el mensaje del commit: ") or "cambios"
        subprocess.run(["git", "commit", "-m", commit_message], check=True)
        print(f"Commit realizado con el mensaje: '{commit_message}'")

        # Hacer push
        subprocess.run(["git", "push"], check=True)
        print("Push realizado exitosamente.")
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar comando: {e}")

if __name__ == "__main__":
    ejecutar_comando_git()

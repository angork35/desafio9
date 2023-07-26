from flask import Flask

app = Flask(__name__)

# Agregamos la línea de impresión
print("La aplicación Flask se está ejecutando...")

@app.route('/')
def hello():
    return '¡Hola, este es un ejemplo de Flask!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import OperationalError
import time
import os

app = Flask(__name__)

# Configuración de la base de datos
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URI', 'postgresql://username:password@postgres:5432/mydatabase')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Intentar conectarse a la base de datos con reintentos
@app.before_first_request
def connect_db_with_retries():
    retries = 5
    while retries > 0:
        try:
            db.session.execute('SELECT 1')
            break
        except OperationalError:
            retries -= 1
            time.sleep(2)
    else:
        raise Exception("Failed to connect to the database")

# Modelo de Usuario
class User(db.Model):
    __tablename__ = 'users' 
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    age = db.Column(db.Integer, nullable=False)

# Rutas
@app.route('/')
def index():
    return "Flask app is running!"

@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    new_user = User(name=data['name'], age=data['age'])
    db.session.add(new_user)
    db.session.commit()
    return jsonify({'message': 'User created', 'data': data}), 201

@app.route('/users', methods=['GET'])
def get_users():
    users = User.query.all()
    users_list = [{'name': user.name, 'age': user.age} for user in users]
    return jsonify(users_list)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
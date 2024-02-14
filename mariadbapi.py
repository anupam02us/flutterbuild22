from flask import Flask, request, jsonify
from flask_cors import CORS
import mariadb

app = Flask(__name__)
CORS(app)
#MariaDB configurations
#Replace below valus with your connections
db_config = {    
        'host': '10.0.0.2', 
        'port': 3306,
        'user': 'ram',    
        'password': 'password', #mariadb setup password 
        'database': 'flask_maria'# replace this with database name which you have created in  MariaDB
}

# Endpoint to get data
@app.route('/get_data', methods=['GET'])
def get_data():
    try:
        conn = mariadb.connect(**db_config)
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM employees")
        data = cursor.fetchall()
        print(data)
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({'error': str(e)})

#Endpoint to insert data
@app.route('/insert_data', methods=['GET','POST'])
def insert_data():
    try:
        data = request.json
        employee_id = data['id']
        first_name = data['fn']
        last_name = data['ln']
        job_title = data['jt']
        salary = data['sl']

        conn = mariadb.connect(**db_config)
        cursor = conn.cursor()

        cursor.execute("INSERT INTO  employees VALUES (?, ?, ?, ?, ?)", (employee_id,first_name,last_name,job_title,salary))
        conn.commit()

        conn.close()
        return jsonify({'message': 'Data inserted successfully'})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

import pandas as pd
import sqlalchemy

# Creating MySQL connection
username = "root"
password = "1201"
host = "localhost"
port = "3306"
database = "netflix_data_analysis"

conn = f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}"

engine = sqlalchemy.create_engine(conn)

connection = engine.connect()

df = pd.read_csv("netflix1.csv")
print(df.head())

df.to_sql(name="Netflix", con=connection)


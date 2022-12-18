import mysql.connector
import re

mydb = mysql.connector.connect(
  host="localhost",
  user="admin",
  password="mypass",
  database="ADDM4RIOTA"
)

print("Starting")

insertCur = mydb.cursor()
mycursor = mydb.cursor()

mycursor.execute("SELECT iot_threat_id, IoTCriticalObjects, ResilientSolutionIds FROM ADDM4RIOTA.threat_type")

myresult = mycursor.fetchall()

for x in myresult:
  iotThreatID,CriticalOBJs,RESSOL_IDs = x
  #print(x)
#   print(f"#### {iotThreatID} ###")
#   print(f"OBJs: {CriticalOBJs}")
#   print(f"RESSOLS: {RESSOL_IDs}")

  critical_OBJs_list = CriticalOBJs.split(" ")
  print(critical_OBJs_list)
  for obj in critical_OBJs_list:
    if obj == '':
        continue
    insertCur.execute(f"insert into ADDM4RIOTA.BRIDGE_iot_critical_object_threat_type values('{obj}','{iotThreatID}');")

  SolutionsID_list = RESSOL_IDs.split(" ")
  p = re.compile('^\w{3,}\d{1,2}$')
  SolutionsID_list = [ s for s in SolutionsID_list if p.match(s) ]
  print(SolutionsID_list)
  for sol in SolutionsID_list:
    query = f"insert into ADDM4RIOTA.BRIDGE_resilient_solution_threat_type values('{sol}','{iotThreatID}');"
    print("Running query:"+query)
    insertCur.execute(query)
  mydb.commit()

print("Finished")


import anvil.server
import mysql.connector


mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="ADDM4RIOTA"
    )
mycursor = mydb.cursor()

anvil.server.connect("MO5EU2C2RI4KEAEJEX7PDP6W-7EHOFIIFZZH76HOQ")

@anvil.server.callable
def say_hello(name):
  print("Hello from the uplink, %s!" % name)

@anvil.server.callable
def getDevices():
    mycursor.execute("SELECT * FROM iot_critical_object")
    return mycursor.fetchall()

@anvil.server.callable
def getThreats():
    mycursor.execute("SELECT * FROM threat_type")
    return  mycursor.fetchall()

@anvil.server.callable
def getResilientSolutions():
    mycursor.execute("SELECT * FROM resilient_solution")
    return [{'id':obj[0],'resilient_solution_id':obj[1],'name':obj[2],'description':obj[3]} for obj in mycursor.fetchall()]

@anvil.server.callable
def getAllThreatTypes():
    mycursor.execute("select * from threat_type_enum")
    return mycursor.fetchall()

@anvil.server.callable
def getAllSolutionTypes():
    mycursor.execute("select * from resilient_solution_enum")
    return mycursor.fetchall()

@anvil.server.callable
def getAllIoTObjectsDropdown():
    mycursor.execute("select * from iot_critical_object")
    return [(obj[1]+" - ("+obj[2]+")",obj[2]) for obj in mycursor.fetchall()]

@anvil.server.callable
def getAllThreatTypesDropdown():
    mycursor.execute("select * from threat_type_enum")
    return [(obj[1] + ' - (' + obj[2]+")",obj[2]) for obj in mycursor.fetchall()]

@anvil.server.callable
def getAllSolutionTypesDropdown():
    mycursor.execute("select * from resilient_solution_enum")
    return [(obj[1] + ' - (' + obj[2]+")",obj[2]) for obj in  mycursor.fetchall()]

@anvil.server.callable
def filterSolutions(solutionDTO):
    # solutionDTO has the format below, the values between quotes should be replaced by the wanted values, or None.
    # ("id", "resilient_solution_id", 'name', 'description', 'references', 'resilient_solution_enum', TT_id)
    query = """select rs.* from (ADDM4RIOTA.threat_type_enum B inner join ADDM4RIOTA.resilient_solution rs
            on B.id = rs.resilient_solution_enum ) where
            cast(rs.id as CHAR) like ifnull(%s,'%') AND
            cast(rs.resilient_solution_id as char) like ifnull(%s,'%') AND
            rs.name like ifnull(%s,'%') AND
            rs.description like ifnull(%s,'%') AND
            rs.references like ifnull(%s,'%') AND
            rs.resilient_solution_enum like ifnull(%s,'%') AND
            B.acronym like ifnull(%s,'%');"""
    mycursor.execute(query,solutionDTO)
    print(mycursor.statement)
    return  [{'id':obj[0],'resilient_solution_id':obj[1],'name':obj[2],'description':obj[3]} for obj in mycursor.fetchall()]


@anvil.server.callable
def filterIoTObjects(iotObjectsDTO):
    # solutionDTO has the format below, the values between quotes should be replaced by the wanted values, or None.
    # ("id", 'name', 'acronym')
    query = """select rs.* from (ADDM4RIOTA.threat_type_enum B inner join ADDM4RIOTA.resilient_solution rs
            on B.id = rs.resilient_solution_enum ) where
            cast(rs.id as CHAR) like ifnull(%s,'%') AND
            cast(rs.resilient_solution_id as char) like ifnull(%s,'%') AND
            rs.name like ifnull(%s,'%') AND
            rs.description like ifnull(%s,'%') AND
            rs.references like ifnull(%s,'%') AND
            rs.resilient_solution_enum like ifnull(%s,'%') AND
            B.acronym like ifnull(%s,'%');"""
    mycursor.execute(query,iotObjectsDTO)
    print(mycursor.statement)
    return  [{'id':obj[0],'resilient_solution_id':obj[1],'name':obj[2],'description':obj[3]} for obj in mycursor.fetchall()]


@anvil.server.callable
def filterThreatTypes(threatTypeDTO):
    # threatTypeDTO has the following format
    # (ttAcronym, ICO_Acronym) Ex.: (ALTT, DVC)
    query = """select tt.* from ADDM4RIOTA.threat_type tt
                where tt.iot_threat_id like CONCAT('%',ifnull(%s,''),'%') AND
                    tt.IoTCriticalObjects like CONCAT('%',ifnull(%s, ''),'%');"""
    mycursor.execute(query,threatTypeDTO)
    # print(mycursor.statement)
    return  mycursor.fetchall()

anvil.server.wait_forever()
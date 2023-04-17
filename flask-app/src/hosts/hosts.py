from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


hosts = Blueprint('hosts', __name__)

# get all lodgings from the database
@hosts.route('/Lodgings', methods=['GET'])
def get_lodgings():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of lodgings
    cursor.execute('SELECT * FROM Lodgings')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# add a new lodging to the databse
@hosts.route('/Lodgings', methods=['POST'])
def add_new_lodging():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    l_name = the_data['LodgingName']
    l_city = the_data['LodgingCity']
    l_country = the_data['LodgingCountry']
    l_region = the_data['LodgingRegion']
    l_street = the_data['LodgingStreet']
    l_street_number = the_data['LodgingStreetNumber']
    l_zip = the_data['LodgingZip']
    l_phone = the_data['LodgingPhone']
    l_username = the_data['LodgingUsername']

    the_query = 'INSERT INTO Lodgings (Name, City, Country, Region, Street, Number, ZIP, PhoneNumber, HostUser) VALUES ("'
    the_query += l_name + '", "'
    the_query += l_city + '", "'
    the_query += l_country + '", "'
    the_query += l_region + '", "'
    the_query += l_street + '", '
    the_query += str(l_street_number) + ', '
    the_query += str(l_zip) + ', '
    the_query += str(l_phone) + ', "'
    the_query += l_username + '")'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# update a lodging in the databse
@hosts.route('/Lodgings/<LodgingCity>/<LodgingName>', methods=['PUT'])
def update_lodging(LodgingCity, LodgingName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    l_name = LodgingName
    l_city = LodgingCity
    l_country = the_data['LodgingCountry']
    l_region = the_data['LodgingRegion']
    l_street = the_data['LodgingStreet']
    l_street_number = the_data['LodgingStreetNumber']
    l_zip = the_data['LodgingZip']
    l_phone = the_data['LodgingPhone']

    the_query = 'UPDATE Lodgings SET Country = "'
    the_query += l_country + '", Region = "'
    the_query += l_region + '", Street = "'
    the_query += l_street + '", Number = '
    the_query += str(l_street_number) + ', ZIP = '
    the_query += str(l_zip) + ', PhoneNumber = '
    the_query += str(l_phone) + ' '
    the_query += 'WHERE City = "' + l_city + '" AND Name = "' + l_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# delete a lodging in the databse
@hosts.route('/Lodgings/<LodgingsCity>/<LodgingsName>', methods=['DELETE'])
def delete_lodging(LodgingsCity, LodgingsName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    l_name = LodgingsName
    l_city = LodgingsCity

    the_query = 'DELETE FROM Lodgings WHERE City = "'
    the_query += l_city + '" AND Name = "'
    the_query += l_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# get all activities from the database
@hosts.route('/Activities', methods=['GET'])
def get_activities():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of activities
    cursor.execute('SELECT * FROM Activities')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# add a new activity to the databse
@hosts.route('/Activities', methods=['POST'])
def add_new_activity():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    a_name = the_data['ActivityName']
    a_location = the_data['ActivityLocation']
    a_description = the_data['ActivityDescription']
    a_category = the_data['ActivityCategory']
    a_price = the_data['ActivityPrice']
    a_availability = the_data['ActivityAvailability']
    a_username = the_data['ActivityUsername']

    the_query = 'INSERT INTO Activities (Name, Location, Description, Category, Price, Availability, HostUser) VALUES ("'
    the_query += a_name + '", "'
    the_query += a_location + '", "'
    the_query += a_description + '", "'
    the_query += a_category + '", '
    the_query += str(a_price) + ', '
    the_query += str(a_availability) + ', "'
    the_query += a_username + '")'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# update an activity in the databse
@hosts.route('/Activities/<ActivityLocation>/<ActivityName>', methods=['PUT'])
def update_activity(ActivityLocation, ActivityName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    a_name = ActivityName
    a_location = ActivityLocation
    a_description = the_data['ActivityDescription']
    a_category = the_data['ActivityCategory']
    a_price = the_data['ActivityPrice']
    a_availability = the_data['ActivityAvailability']

    the_query = 'UPDATE Activities SET Description = "'
    the_query += a_description + '", Category = "'
    the_query += a_category + '", Price = '
    the_query += str(a_price) + ', Availability = '
    the_query += str(a_availability) + ' '
    the_query += 'WHERE Location = "' + a_location + '" AND Name = "' + a_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# delete an activity in the databse
@hosts.route('/Activities/<ActivityLocation>/<ActivityName>', methods=['DELETE'])
def delete_activity(ActivityLocation, ActivityName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    a_name = ActivityName
    a_location = ActivityLocation

    the_query = 'DELETE FROM Activites WHERE Location = "'
    the_query += a_location + '" AND Name = "'
    the_query += a_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"
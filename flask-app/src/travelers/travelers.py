from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


travelers = Blueprint('travelers', __name__)

# get all lodgings from the database
@travelers.route('/Itineraries/{Name}', methods=['GET'])
def get_itineraries():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    username = the_data['TravelerOrganizer']

    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of itineraries from a user
    the_query = 'SELECT * FROM Itineraries WHERE TravelerOrganizer = "'
    the_query += username + '"'
    cursor.execute(the_query)

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

# add a new itinerary to the databse
@travelers.route('/Itineraries', methods=['POST'])
def add_new_itinerary():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    i_name = the_data['ItineraryName']
    i_trav_organizer = the_data['ItineraryTravelerOrganizer']
    i_total_price = the_data['ItineraryTotalPrice']

    the_query = 'INSERT INTO Itineraries (Name, TravelerOrganizer, TotalPrice) VALUES ("'
    the_query += i_name + '", "'
    the_query += i_trav_organizer + '", '
    the_query += str(i_total_price) + ')'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# update an itinerary in the databse
@travelers.route('/Itineraries/{Name}', methods=['PUT'])
def update_itinerary():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    i_name = the_data['ItineraryName']
    i_total_price = the_data['ItineraryTotalPrice']

    the_query = 'UPDATE Itineraries SET TotalPrice = '
    the_query += str(i_total_price) + ' '
    the_query += 'WHERE Name = "' + i_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# delete an itinerary in the databse
@travelers.route('/Itineraries/{Name}', methods=['DELETE'])
def delete_itinerary():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    i_name = the_data['ItineraryName']

    the_query = 'DELETE FROM Itineraries WHERE Name = "'
    the_query += i_name + '"'

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

    # use cursor to query the database for a list of lodgings
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
@hosts.route('/Activities/{Location}/{Name}', methods=['PUT'])
def update_activity():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    a_name = the_data['ActivityName']
    a_location = the_data['ActivityLocation']
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
@hosts.route('/Activities/{Location}/{Name}', methods=['DELETE'])
def delete_activity():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    a_name = the_data['ActivityName']
    a_location = the_data['ActivityLocation']

    the_query = 'DELETE FROM Activites WHERE Location = "'
    the_query += a_location + '" AND Name = "'
    the_query += a_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"
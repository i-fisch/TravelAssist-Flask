from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


travelers = Blueprint('travelers', __name__)

# get all lodgings from the database
@travelers.route('/Itineraries/<TravelerOrganizer>', methods=['GET'])
def get_itineraries(TravelerOrganizer):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    username = TravelerOrganizer

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
@travelers.route('/Itineraries/<ItineraryName>', methods=['PUT'])
def update_itinerary(ItineraryName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    i_name = ItineraryName
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
@travelers.route('/Itineraries/<ItineraryName>', methods=['DELETE'])
def delete_itinerary(ItineraryName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    i_name = ItineraryName

    the_query = 'DELETE FROM Itineraries WHERE Name = "'
    the_query += i_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# get all activities from a certain itinerary
@travelers.route('/Act_Itin/<ItineraryName>', methods=['GET'])
def get_itin_activities(ItineraryName):
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    the_data = request.get_json()
    current_app.logger.info(the_data)

    i_name = ItineraryName

    the_query = 'SELECT * FROM Act_Itin '
    the_query += 'WHERE ItineraryName = "' + i_name + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
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

# add a new activity to an itinerary
@travelers.route('/Act_Itin', methods=['POST'])
def add_itin_activity():
    the_data = request.get_json()
    current_app.logger.info(the_data)

    a_name = the_data['ActivityName']
    a_location = the_data['Location']
    i_name = the_data['ItineraryName']
    a_time = the_data['Datetime']

    the_query = 'INSERT INTO Act_Itin (ActivityName, Location, ItineraryName, Datetime) VALUES ("'
    the_query += a_name + '", "'
    the_query += a_location + '", "'
    the_query += i_name + '", '
    the_query += str(a_time) + ')'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# update an activity in an itinerary
@travelers.route('/Act_Itin/<ItineraryName>/<Location>/<ActivityName>', methods=['PUT'])
def update_itin_act(ItineraryName, Location, ActivityName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    # changed to include location and activity name as inputs
    # bc broke thunderclient
    # but also bc are part of pk so can't refer to row in table w/o them
    a_name = ActivityName
    a_location = Location
    i_name = ItineraryName
    a_time = the_data['Datetime']

    the_query = 'UPDATE Act_Itin SET ActivityName = "'
    the_query += a_name + '", Location = "'
    the_query += a_location + '", Datetime = '
    the_query += str(a_time) + ' '
    the_query += 'WHERE ItineraryName = "' + i_name + '"'
    the_query += ' AND ActivityName = "' + a_name + '"'
    the_query += ' AND Location = "' + a_location + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"

# delete an activity in an itinerary
@travelers.route('/Act_Itin/<ItineraryName>/<Location>/<ActivityName>', methods=['DELETE'])
def delete_activity(ItineraryName, Location, ActivityName):
    the_data = request.get_json()
    current_app.logger.info(the_data)

    a_name = ActivityName
    i_name = ItineraryName
    a_location = Location


    the_query = 'DELETE FROM Act_Itin WHERE ItineraryName = "'
    the_query += i_name + '" AND ActivityName = "'
    the_query += a_name + '" AND Location = "'
    the_query += a_location + '"'

    current_app.logger.info(the_query)
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return "Success!"
from flask import Flask, request, jsonify, render_template, redirect, url_for, session, flash
from datetime import datetime
import mysql.connector

#app = Flask(__name__)
app = Flask(__name__, template_folder='templates')

# Database configuration
db_config = {
    'user': 'root',
    'password': 'Trafficlight@24',
    'host': 'localhost',
    'database': 'curious_camper',
    'raise_on_warnings': True
}

app.secret_key = 'CS5200DBMS'


#authenticate user/admin at login 
def authenticate_user(username, password, user_type):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    if user_type == 'user':
        query = "SELECT * FROM user WHERE user_Name = %s AND user_password = %s"
    elif user_type == 'admin':
        query = "SELECT * FROM admin WHERE admin_username = %s AND admin_password = %s"
    else:
        return None

    cursor.execute(query, (username, password))
    user = cursor.fetchone()

    cursor.close()
    conn.close()

    return user


#LOGIN
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # Process login form data here (validate credentials, etc.)
        username = request.form['username']
        password = request.form['password']
        user_type = request.form['user_type'] 
        # Add your authentication logic here (e.g., check against a database)
        user = authenticate_user(username, password, user_type)

        #if user is not None:
        if user_type== 'user' and user:
            return redirect(url_for('user_dashboard'))
        elif user_type == 'admin' and user:
            return redirect(url_for('admin_dashboard'))
        else:
            return render_template('login.html', error='Invalid credentials')

    return render_template('login.html', error=None)

#define the default page : this way when we first access the ip we get login page first
@app.route('/')
def default():
    return render_template('login.html')

@app.route('/add_amenity', methods=['GET', 'POST'])
def add_amenity():
    if request.method == 'GET':
        return render_template('add_amenity.html')
    elif request.method == 'POST':
        # If it's a POST request, process the form data and add the amenity
        try:
            args = [
                request.form['adminUsername'],
                request.form['amenityName'],
                int(request.form['streetNumber']),
                request.form['streetName'],
                request.form['city'],
                request.form['state'],
                request.form['zipcode'],
                float(request.form['distance']),
                request.form['typeName'],
                int(request.form['campsiteId'])
            ]

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            # Call the stored procedure with the provided arguments
            cursor.callproc('AddAmenities', args)

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)})


@app.route('/add_campsite', methods=['GET', 'POST'])
def add_campsite():
    if request.method == 'GET':
        # If it's a GET request, render the add_campsite.html page
        return render_template('add_campsite.html')
    elif request.method == 'POST':
        # If it's a POST request, process the form data and add the campsite
        try:
            args = [
                request.form['adminUsername'],
                request.form['campsiteName'],
                int(request.form['streetNumber']),
                request.form['streetName'],
                request.form['city'],
                request.form['state'],
                request.form['zipcode'],
                int(request.form['spotsAvailable']),
                float(request.form['pricePerNight'])
            ]

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('AddCampsite', args)

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)})


@app.route('/DeleteCampsite', methods=['GET', 'POST'])
def delete_campsite():
    if request.method == 'GET':
        # If it's a GET request, render the delete_campsite.html page
        return render_template('delete_campsite.html')
    elif request.method == 'POST':
        # If it's a POST request, process the form data and delete the campsite
        try:
            admin_username = request.form['adminUsername']
            campsite_id = int(request.form['campsiteId'])

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('DeleteCampsite', [admin_username, campsite_id])

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)})


@app.route('/DeleteAmenity', methods=['GET', 'POST'])
def delete_amenity():
    if request.method == 'POST':
        try:
            # Handle POST request logic
            admin_username = request.form['adminUsername']
            amenity_id = request.form['amenityId']

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('DeleteAmenities', [admin_username, amenity_id])

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)})
    else:
        # Handle GET request logic (e.g., render a form)
        return render_template('delete_amenity.html')



# update user profile
@app.route('/update_userprofile', methods=['GET','POST','PUT'])
def update_user_profile():
    try:
        current_user_name = request.form['currentUserName']
        new_name = request.form['newName']
        new_email = request.form['newEmail']
        new_phone_number = request.form['newPhoneNumber']

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        cursor.callproc('UpdateUserProfile', [current_user_name, new_name, new_email, new_phone_number])

        conn.commit()

        cursor.close()
        conn.close()
        

        return render_template('update_userprofile.html', success=True)
    except Exception as e:
        # If an error occurs, render the template with an error variable
        return render_template('update_userprofile.html', success=False, error=str(e))
        


# defining route for user page post user authentication 
@app.route('/user', methods=['GET'])
def user_dashboard():
    # Render the user dashboard template
    return render_template('user_dashboard.html')

#define route for admin login post admin authentication

@app.route('/admin', methods=['GET'])
def admin_dashboard():
    # Render the admin dashboard template
    return render_template('admin_dashboard.html')


@app.route('/BookCampsite', methods=['GET', 'POST'])
def book_campsite():
    if request.method == 'POST':
        try:
            user_name = request.form['userName']
            campsite_id = request.form['campsiteId']
            start_date = request.form['startDate']
            end_date = request.form['endDate']
            num_guests = request.form['numGuests']
            payment_method = request.form['paymentMethod']

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('BookCampsite', [user_name, campsite_id, start_date, end_date, num_guests, payment_method])
            conn.commit()

            results = [result.fetchall() for result in cursor.stored_results()]
            cursor.close()
            conn.close()

            return jsonify({'success': True, 'results': results})
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)})

    elif request.method == 'GET':
        # Handle GET request logic here, if needed
        return render_template('book_campsite.html')  # Replace with your template

    else:
        # Handle other HTTP methods, if needed
        return jsonify({'success': False, 'error': 'Method Not Allowed'})


#ADD REVIEW
# Change the methods=['GET', 'POST'] to accept both GET and POST requests
@app.route('/add_review', methods=['GET', 'POST'])
def add_review():
    if request.method == 'POST':
        try:
            userName = request.form['userName']
            campsiteId = request.form['campsiteId']
            rating = request.form['rating']
            comments = request.form['comments']

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('AddReview', [userName, campsiteId, rating, comments])

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)})
    else:
        # If it's a GET request, render the HTML template
        return render_template('review.html')


#GENERATE SUPPORT TICKET
# Modify your Flask route
@app.route('/generate_support_ticket', methods=['GET'])
def show_generate_support_ticket_form():
    return render_template('generate_support_ticket.html')

# The route to handle form submission
@app.route('/generate_support_ticket', methods=['POST'])
def generate_support_ticket():
    try:
        user_name = request.form['userName']
        issue_type = request.form['issueType']
        issue_description = request.form['issueDescription']

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        args = [user_name, issue_type, issue_description, 0]
        cursor.callproc('GenerateSupportTicket', args)

        cursor.execute('SELECT COALESCE(MAX(ticket_ID), 0) FROM support_Ticket')
        ticket_id = cursor.fetchone()[0]

        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({'success': True, 'ticketId': ticket_id})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})




@app.route('/CancelBooking', methods=['GET', 'POST'])
def cancel_booking():
    try:
        if request.method == 'POST':
            # Logic for handling POST requests
            args = [
                request.form['userName'],
                int(request.form['bookingId'])
            ]

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('CancelBooking', args)

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        elif request.method == 'GET':
           return render_template('cancel_booking.html')

        else:
            # Handle other request methods if needed
            return jsonify({'success': False, 'error': 'Unsupported method'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

# Booking Confirmation route
# Booking Confirmation route
@app.route('/isBookingConfirmed', methods=['GET', 'POST'])
def is_booking_confirmed():
    if request.method == 'POST':
        data = request.json  # Assuming you're sending data in JSON format
        user_name = data.get('userName')
        booking_date = data.get('bookingDate')
        campsite_id = data.get('campsiteId')

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        query = "SELECT IsBookingConfirmed(%s, %s, %s)"
        cursor.execute(query, (user_name, booking_date, campsite_id))
        result = cursor.fetchone()

        cursor.close()
        conn.close()

        return jsonify({'isConfirmed': result[0]})
    elif request.method == 'GET':
        # Logic for handling GET requests
       return render_template('booking_confirmation.html')
    else:
        # Handle other request methods if needed
        return jsonify({'error': 'Unsupported method'})
#logout


@app.route('/logout', methods=['GET', 'POST'])
def logout():
    try:
        # Clear user session
        session.clear()
        print("Session cleared successfully")
        # Redirect to the login page (adjust the route as needed)
        return redirect(url_for('login'))
    except Exception as e:
        print(f"An error occurred during logout: {str(e)}")
        return jsonify({'success': False, 'error': str(e)})

# Alter booking
@app.route('/AlterBooking', methods=['GET', 'POST'])
def alter_booking():
    try:
        if request.method == 'POST':
            # Logic for handling POST requests
            args = [
                request.form['userName'],
                int(request.form['bookingId']),
                request.form['newStartDate'],
                request.form['newEndDate'],
                int(request.form['newNumGuests'])
            ]

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('AlterBooking', args)

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        elif request.method == 'GET':
            return render_template('alter_booking.html')
        else:
            # Handle other request methods if needed
            return jsonify({'success': False, 'error': 'Unsupported method'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})


# Campsite availability checker
# Campsite availability checker
@app.route('/CheckCampsiteAvailability', methods=['GET', 'POST'])
def check_campsite_availability():
    try:
        show_message = False  # Default to False

        if request.method == 'POST':
            # Logic for handling POST requests
            input_state = request.form['inputState']
            input_guests = int(request.form['inputGuests'])

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor(dictionary=True)

            cursor.callproc('CheckCampsiteAvailability', [input_state, input_guests])

            results = []
            for result in cursor.stored_results():
                results = result.fetchall()

            cursor.close()
            conn.close()

            show_message = True  # Set to True if form is submitted

            return render_template('campsite_availability.html', data=results, show_message=show_message)
        elif request.method == 'GET':
            return render_template('campsite_availability.html', show_message=show_message)
        else:
            # Handle other request methods if needed
            return jsonify({'success': False, 'error': 'Unsupported method'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/CountBookingsByDate', methods=['GET', 'POST'])
def count_bookings_by_date():
    if request.method == 'POST':
        try:
            check_date = request.form['checkDate']

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            query = "SELECT CountBookingsByDate(%s)"
            cursor.execute(query, (check_date,))
            booking_count = cursor.fetchone()[0]

            cursor.close()
            conn.close()

            #return jsonify({'bookingCount': booking_count})
            return render_template('count_booking_by_date.html', booking_result=booking_count)
        except Exception as e:
            return jsonify({'error': str(e)})

    # If it's a GET request, render the template
    return render_template('count_booking_by_date.html', )



@app.route('/resolve_support_ticket', methods=['GET', 'POST'])
def resolve_support_ticket():
    if request.method == 'GET':
        # Your logic to render the form goes here
        return render_template('resolve_support_ticket.html')
    elif request.method == 'POST':
        try:
            ticket_id = request.form['ticketId']
            resolution = request.form['resolution']

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            cursor.callproc('ResolveSupportTicket', [ticket_id, resolution])

            conn.commit()

            cursor.close()
            conn.close()

            return jsonify({'success': True})
        except Exception as e:
            return jsonify({'success': False, 'error': str(e)})

@app.route('/get_average_rating', methods=['GET', 'POST'])
def get_average_rating():
    if request.method == 'POST':
        try:
            campsite_id = int(request.form['campsiteId'])

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            query = "SELECT GetAverageRating(%s)"
            cursor.execute(query, (campsite_id,))
            avg_rating = cursor.fetchone()[0]

            cursor.close()
            conn.close()

            return render_template('average_rating.html', avg_rating=avg_rating)
        except Exception as e:
            return render_template('average_rating.html', error=str(e))

    # If it's a GET request, render the template without results
    return render_template('average_rating.html')


if __name__ == '__main__':
    app.run(debug=True)



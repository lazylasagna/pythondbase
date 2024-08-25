params = [
    {
        'title': 'Tours',
        'table_name': 'tours',
        'columns': ('Id', 'Title', 'Description', 'Start Date', 'End Date', 'Country', 'City'),
        'sort': [int, str, str, str, str, str, str],
        'column_width': [110, 230, 300, 140, 140, 180, 180],
        'bd_columns': ['id', 'title', 'description', 'start_date', 'end_date', 'country', 'city']
    },
    {
        'title': 'Hotels',
        'table_name': 'hotels',
        'columns': ('Id', 'Title', 'Address', 'Contacts', 'Rooms', 'Country', 'City'),
        'sort': [int, str, str, str, int, str, str],
        'column_width': [110, 280, 250, 180, 110, 170, 160],
        'bd_columns': ['id', 'title', 'address', 'contact_information', 'number_of_rooms', 'country', 'city']
    },
    {
        'title': 'Hotel Rooms',
        'table_name': 'hotel_rooms',
        'columns': ('Id', 'Start Date', 'End Date', 'Hotel Id', 'Booking Id', 'Category'),
        'sort': [int, str, str, int, int, str],
        'column_width': [110, 100, 100, 100, 100, 100],
        'bd_columns': ['id', 'start_date', 'end_date', 'hotel_id', 'booking_id', 'category']

    },
    {
        'title': 'Booking',
        'table_name': 'booking',
        'columns': ('Id', 'Tourist Id', 'Tour Id', 'Start Date', 'End Date'),
        'sort': [int, int, int, str, str],
        'column_width': [110, 100, 100, 100, 100],
        'bd_columns': ['id', 'tourist_id', 'tour_id', 'tour_start_date', 'tour_end_date']

    },
    {
        'title': 'Excursions',
        'table_name': 'excursions',
        'columns': ('Id', 'Title', 'Description', 'Start Date', 'End Date', 'Place'),
        'sort': [int, str, str, str, str, str],
        'column_width': [90, 210, 220, 100, 100, 140],
        'bd_columns': ['id', 'title', 'description', 'start_date', 'end_date', 'place']
    },
    {
        'title': 'Booked Excursions',
        'table_name': 'booked_excursions',
        'columns': ('Id', 'Booking Id', 'Excursions Id'),
        'sort': [int, int, int],
        'column_width': [110, 100, 100],
        'bd_columns': ['id', 'tourist_id', 'tour_id', 'tour_start_date', 'tour_end_date']
    },
    {
        'title': 'Tourists',
        'table_name': 'tourists',
        'columns': ('Id', 'First Name', 'Last Name', 'Birth Date', 'Gender', 'Phone Number', 'Passport', 'Main'),
        'sort': [int, str, str, str, str, str, str, int],
        'column_width': [100, 180, 180, 150, 100, 200, 100, 80],
        'bd_columns': ['id', 'firstname', 'lastname', 'birth_date', 'gender', 'phone_number', 'passport', 'main']
    },
    {
        'title': 'Visas',
        'table_name': 'visas',
        'columns': ('Id', 'Country', 'Date Of Issue', 'Expiry Date', 'Tourist Id'),
        'sort': [int, str, str, str, int],
        'column_width': [110, 100, 100, 100, 100],
        'bd_columns': ['id', 'destination_country', 'date_of_issue', 'expiry_date', 'tourist_id']
    },
    {
        'title': 'Transfer Companies',
        'table_name': 'transfer_companies',
        'columns': ('Id', 'Title', 'Contact Information', 'Type'),
        'sort': [int, str, str, str],
        'column_width': [110, 100, 100, 100],
        'bd_columns': ['id', 'title', 'contact_information', 'type']
    },
    {
        'title': 'Transfers',
        'table_name': 'transfers',
        'columns': ('Id', 'Transfer Company Id', 'Start Date', 'End Date', 'Departure Place', 'Arrival Place', 'Booking Id'),
        'sort': [int, int, str, str, str, int],
        'column_width': [110, 100, 100, 100, 100, 100, 100],
        'bd_columns': ['id', 'transfer_company_id', 'start_date', 'end_date', 'place_of_departure', 'place_of_arrival', 'booking_id']
    },
]
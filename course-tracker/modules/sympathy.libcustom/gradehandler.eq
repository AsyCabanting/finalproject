public class gradehandler : HTTPRequestHandler {
    //The SQLDatabase data type can represent any kind of SQl database.

    SQLDatabase db;


	//The "configure()" method is called on each handler upon initialization. This is where one can receive and 
	//interpret any settings and/or do any other initialization tasks.
	
    public bool configure(File appdir, HashTable settings) {
        if(base.configure(appdir,settings) == false) {
            return(false);
        }

        //Open the database: An SQLite database, saved as a file within the site directory.
        db = SQLiteDatabase.for_file(appdir.entry("mydb.sqlite"), true, get_logger());
        
		if(db == null) {
            log_error("Failed to open database.");
            return(false);
        }
   
        //If the database table is not yet created, create it here.
		if(db.table_exists("mytable") == false) {
            log_debug("Creating database table.");
            var columns = LinkedList.create();
            columns.add(SQLTableColumnInfo.instance("id", SQLTableColumnInfo.TYPE_INTEGER_KEY));
            columns.add(SQLTableColumnInfo.instance("text", SQLTableColumnInfo.TYPE_TEXT));
            if(db.create_table("mytable", columns) == false) {
                log_error("Failed to create database table.");
                return(false);
            }
            insert_record("Welcome!");
            insert_record("Hello!");
            insert_record("Greetings!");
            insert_record("Hey!");
            insert_record("Whats Up?!");
        }
 	   //All initialization is successfully done.
        log_message("SimpleDatabaseHandler initialization complete.");
        return(true);
    }

    //The "get()" method is called to service HTTP GET requests.
    
    public void get(HTTPRequest req) {
        var sql = "Select * from mytable;"; //The sql query to execute
        var stmt = db.prepare(sql);         //First prepare the statement.
        var rs = db.query(stmt);            //Then execute the query
        var array = Array.create();

        // Then generate an HTML response from the recordset and send it back to the client
        var sb = StringBuffer.create();
        sb.append("<html><head><title>Simple Database Handler sample</title></head><body>");        
		foreach(HashTable record in rs) {
            array.add(record.get_string("text")); 
        }
        sb.append("</body></html>");
		int length=array.count();
		req.send_json(HashTable.create().set("greetings", array.get(Math.random(0,length))));
    }   

    //Insert text strings into the database (sample data)
    bool insert_record(String data) {
        var sql = "INSERT INTO mytable ( text ) VALUES ( ? );";
        var stmt = db.prepare(sql);
        stmt.add_param_str(data);
        return(db.execute(stmt));
    }

	bool delete_record(String data) {
			var sql ="DELETE FROM mytable WHERE ( id ) = ( ? );";
			var stmt = db.prepare(sql);
			stmt.add_param_str(data);
			return(db.execute(stmt));
	}

	public void post(HTTPRequest req) {
	
		var data = req.get_body_json_hash_table();

		if(data != null) {
			insert_record(data.get_string("text1"));
		
		}
	req.send_response(HTTPResponse.for_html_string("<center><b>Content Saved!</b><br><br><form method=link action=\"/index\"><input type=\"submit\" value=\"HOME\" /></form><form method=link action=\"/database\"><input type=\"submit\" value=\"Go to Database\" /></form> "));
	}
}
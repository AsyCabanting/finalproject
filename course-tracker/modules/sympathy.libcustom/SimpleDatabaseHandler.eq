public class SimpleDatabaseHandler : HTTPRequestHandler {
 


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
            columns.add(SQLTableColumnInfo.instance("subject", SQLTableColumnInfo.TYPE_TEXT));
			columns.add(SQLTableColumnInfo.instance("score", SQLTableColumnInfo.TYPE_TEXT));
            if(db.create_table("mytable", columns) == false) {
                log_error("Failed to create database table.");
                return(false);
            }
            insert_record("Seatwork","100/100");
			insert_record("Homework","15/20");
			insert_record("Project","92/100");
            insert_record("Quiz","20/30");
        }
 	   //All initialization is successfully done.
        log_message("SimpleDatabaseHandler initialization complete.");
        return(true);
    }

  
    public void get(HTTPRequest req) {
        var sql = "Select * from mytable;"; //The sql query to execute
        var stmt = db.prepare(sql);         //First prepare the statement.
        var rs = db.query(stmt);            //Then execute the query
        var array = Array.create();

        // Then generate an HTML response from the recordset and send it back to the client
        var sb = StringBuffer.create();
        sb.append("<html><head><title>Simple Database Handler sample</title></head><body>");        
		foreach(HashTable record in rs) {
			HashTable hash = HashTable.create();
			hash.set("subject",record.get_string("subject"));
			hash.set("grade",record.get_string("score"));
			hash.set("id",record.get_string("id"));
	
            array.add(hash); 
        }
        sb.append("</body></html>");
		int length=array.count();
		req.send_json(HashTable.create().set("grades", array));
    }   

   bool insert_record(String data String data2) {
        var sql = "INSERT INTO mytable ( subject,score ) VALUES ( ?,? );";
        var stmt = db.prepare(sql);
        stmt.add_param_str(data);
		stmt.add_param_str(data2);
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
			insert_record(data.get_string("text"),data.get_string("grade"));
		
		}
	req.send_response(HTTPResponse.for_html_string("<center><b>Content Saved!</b><br><br><form method=link action=\"/index\"><input type=\"submit\" value=\"HOME\" /></form><form method=link action=\"/database\"><input type=\"submit\" value=\"Go to Database\" /></form> "));
	}
}
package org.bigbluebutton.pbx;

import groovy.lang.Binding;
import groovy.sql.Sql;
import groovy.util.GroovyScriptEngine;
import groovy.util.ResourceException;
import groovy.util.ScriptException;

import java.io.IOException;
import java.sql.SQLException;

import org.asteriskjava.fastagi.AgiChannel;
import org.asteriskjava.fastagi.AgiException;
import org.asteriskjava.fastagi.AgiRequest;
import org.asteriskjava.fastagi.AgiScript;

public class PbxAgi implements AgiScript {
    private GroovyScriptEngine gse;
    private Sql db;
    
    public PbxAgi(String url, String username, String password, String driver) throws IOException
    {
    	System.out.println("INITIALIZING PBX-AGI");
    	try {
			db = Sql.newInstance(url, username, password, driver);

			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                
    	String[] roots = new String[] { "agi/scripts/" };
        this.gse = new GroovyScriptEngine(roots);
    }

    public void service(AgiRequest request, AgiChannel channel)
            throws AgiException
    {
        String script;
        Binding binding;

        script = request.getScript();
        binding = new Binding();
        binding.setVariable("request", request);
        binding.setVariable("channel", channel);
        binding.setVariable("db", db);
        try
        {
        	System.out.println(script.toString());
            gse.run(script, binding);
        }
        catch (ResourceException e)
        {
            throw new AgiException("Unable to load groovy script '" + script + "'", e);
        }
        catch (ScriptException e)
        {
            throw new AgiException("Exception while running groovy script '" +
                    script + "'", e);
        }
    }
}
package org;
import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;


public class BrowseHere extends Thread {
    private File rootDir;
    private ServerSocket serverSocket;
    private boolean _running = true;

    public static final String VERSION = "1.0";
    public static final Map<String, String> MIME_TYPES = MimeTypes.MIME_TYPES;
    
    
    /**
     * Starts the webserver
     * @param rootDir The root directory where the server should run
     * @param port the port to listen at
     * @throws IOException
     */
    public BrowseHere(File rootDir, int port) throws IOException {
        this.rootDir = rootDir.getCanonicalFile();
        
        if (!this.rootDir.isDirectory()) {
            throw new IOException("Not a directory.");
        }
        
        serverSocket = new ServerSocket(port);
        start();
    }
    
    /**
     * Changes the root directory where the server runs.
     * This method can be called while the server is running, and it will take effect right 
     * in the next request.  
     * @param rootDir the new directory.
     */
    public void setRootDir(File rootDir) {
    	this.rootDir = rootDir;
    }
    
    /**
     * Stops the webserver
     */
    public void stopServer() {
    	try {
    		serverSocket.close();
    		interrupt();
    	}
    	catch (Exception e) {}
    }
    
    public void run() {
        while (_running) {
            try {
                Socket socket = serverSocket.accept();
                RequestThread requestThread = new RequestThread(socket, rootDir);
                requestThread.start();
            }
            catch (Exception e) {
                System.exit(1);
            }
        }
    }
    /*
    public static void main(String[] args) {
        try {
            new BrowseHere(new File("./"), 80);
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }*/
    
     public static void main(String[] args) {
        try {
            System.out.println("usage java -jar BrowseHere.jar 3030 dirPath");

            String portValue = args != null && args.length > 0 ? args[0] : "3030";
            String dirPath   = args != null && args.length > 1 ? args[1] : "./"  ;
            int port = parsePort(portValue);
            String dir = dirPath;
            
            new BrowseHere(new File(dir), port);
            System.out.println("server started at port=" + port + " dir=" + dir + " you can browse files at http://hostname:" + port);
        }
        catch (Exception e) {
            e.printStackTrace(System.err);
        }
    }
    
    private static int parsePort(String sport){
    int port = 0;
        try{
        port = Integer.parseInt(sport);
        }catch(Exception e){
        ;//ignore
        }
        
     return port;
    }
}

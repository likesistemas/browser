package br.com.likesistemas.openBrowser;

import java.io.IOException;

public class Main {

    public static void main(String[] args) throws IOException {
       Runtime runtime = Runtime.getRuntime();
       runtime.exec("rundll32 url.dll,FileProtocolHandler " + (args.length >= 1 ? args[0] : "http://127.0.0.1/"));
    }

}
package com.utils;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;



/**
 * 跨域请求工具类
 * 
 * @author sunghappy
 * @version 2015-07-17
 * 
 */
public class HttpClientUtils {

	 /*public static void main(String[] args) throws Exception {
	        BasicCookieStore cookieStore = new BasicCookieStore();
	        CloseableHttpClient httpclient = HttpClients.custom()
	                .setDefaultCookieStore(cookieStore)
	                .build();
	        try {
	            HttpGet httpget = new HttpGet("https://someportal/");
	            CloseableHttpResponse response1 = httpclient.execute(httpget);
	            try {
	                HttpEntity entity = response1.getEntity();

	                System.out.println("Login form get: " + response1.getStatusLine());
	                EntityUtils.consume(entity);

	                System.out.println("Initial set of cookies:");
	                List<Cookie> cookies = cookieStore.getCookies();
	                if (cookies.isEmpty()) {
	                    System.out.println("None");
	                } else {
	                    for (int i = 0; i < cookies.size(); i++) {
	                        System.out.println("- " + cookies.get(i).toString());
	                    }
	                }
	            } finally {
	                response1.close();
	            }

	            HttpUriRequest login = RequestBuilder.post()
	                    .setUri(new URI("https://someportal/"))
	                    .addParameter("IDToken1", "username")
	                    .addParameter("IDToken2", "password")
	                    .build();
	            CloseableHttpResponse response2 = httpclient.execute(login);
	            try {
	                HttpEntity entity = response2.getEntity();

	                System.out.println("Login form get: " + response2.getStatusLine());
	                EntityUtils.consume(entity);

	                System.out.println("Post logon cookies:");
	                List<Cookie> cookies = cookieStore.getCookies();
	                if (cookies.isEmpty()) {
	                    System.out.println("None");
	                } else {
	                    for (int i = 0; i < cookies.size(); i++) {
	                        System.out.println("- " + cookies.get(i).toString());
	                    }
	                }
	            } finally {
	                response2.close();
	            }
	        } finally {
	            httpclient.close();
	        }
	    }*/
	 
	 /**
	  * get请求
	  * @param url get请求地址
	  */
	 public void doGet(String url){
		 BasicCookieStore cookieStore = new BasicCookieStore();
	        CloseableHttpClient httpclient = HttpClients.custom()
	                .setDefaultCookieStore(cookieStore)
	                .build();
	        
	        //http://www.qb178.com/ajax/sms.jsp?tel=15313039488&type=1&numType=  短信
	        //http://www.qb178.com/ajax/sms.jsp?tel=15313039488&type=1&numType=s  语音
	        
	        //http://passport.colourlife.com/site/SendMsg?mobile=15009889023&type=0&_=1439450405213
	        
	        //url = "http://passport.colourlife.com/site/SendMsg?mobile=15009889023&type=0&_=1439450405213";
	        
	        url = "http://www.qb178.com/ajax/sms.jsp?tel=15222008327&type=1&numType=s";
	        
			try {
				HttpUriRequest get = RequestBuilder.get()
						.setUri(new URI(url))
						.build();
				CloseableHttpResponse response = httpclient.execute(get);
				HttpEntity entity = response.getEntity();

				//String xmlContent=EntityUtils.toString(entity);
				
				//System.out.println(xmlContent);
				
				
                System.out.println("Login form get: " + response.getStatusLine());
                EntityUtils.consume(entity);
                
                if (entity != null) {  
                    System.out.println("返回结果内容编码是：" + entity.getContentEncoding());  
                    System.out.println("返回结果内容类型是：" + entity.getContent().toString());  
                }  

                System.out.println("Post logon cookies:");
                List<Cookie> cookies = cookieStore.getCookies();
                if (cookies.isEmpty()) {
                    System.out.println("None");
                } else {
                    for (int i = 0; i < cookies.size(); i++) {
                        System.out.println("- " + cookies.get(i).toString());
                    }
                }
			} catch (Exception e) {
				e.printStackTrace();
			}
	 }
	 
	 public static void main(String[] args) {
		 new HttpClientUtils().doGet("");
	}
}

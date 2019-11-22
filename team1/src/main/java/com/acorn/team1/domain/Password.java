package com.acorn.team1.domain;

import java.security.MessageDigest;
import java.util.UUID;

public class Password {

	    //< 임시 비밀번호 자동 생성 -랜덤으로 숫자와 영어(소문자)만을 조합하여 임시비밀번호가 생성>
    	//UUID는 유니버셜한 ID를 만드는 표준기술로 다른 말로는 범용 고유 번호라고 불리며 128 비트의 숫자와 영어(소문자)의 조합으로 만들어 짐
		public static String CreatePassword() {
		
			   // UUID 자체는 Object 타입이기 때문에 toString() 메서드를 이용해 String 타입으로 바꿔 줘야 함.
			   //String uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거
				String pw = UUID.randomUUID().toString().replaceAll("-",""); 
				
				//uuid = uuid.substring(0,10); //uuid를 앞에서부터 10자리 잘라줌.
				pw = pw.substring(0,10);
				System.out.println("Password created");
		
			return pw;
			
		}

		//sha256 방식으로 해시값을 생성하는 암호화 메소드
		public static String encryption(String pw) { //매개변수에 param 값으로 넘어온 비밀번호를 넣어주기
			
			try {
				MessageDigest md = MessageDigest.getInstance("SHA-256");
				md.update(pw.getBytes());
				byte byteData[] = md.digest();
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < byteData.length; i++) {
					sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				}
				StringBuffer hexString = new StringBuffer();
				for (int i = 0; i < byteData.length; i++) {
					String hex = Integer.toHexString(0xff & byteData[i]);
					if (hex.length() == 1) {
						hexString.append('0');
					}
					hexString.append(hex);
				}
				return hexString.toString();
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}


			
			
		}
		
	
}

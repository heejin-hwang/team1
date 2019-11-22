package com.acorn.team1.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor

public class LoginDTO {  //화면에서 전달되는 데이터를 수집하는 용도

	
	private String password;
	private String userId;
	private String birthday;
	private String name;
	private boolean useCookie;	
	
}

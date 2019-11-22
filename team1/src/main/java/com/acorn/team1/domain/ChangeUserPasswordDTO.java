package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChangeUserPasswordDTO {

	private String userId;
	private String name;
	private String birthday;
	private String password;
	private String newPassword;
	private String confirmNewPassword;
	private boolean useCookie;
	
}

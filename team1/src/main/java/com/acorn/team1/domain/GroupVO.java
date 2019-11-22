package com.acorn.team1.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GroupVO {
	private int id;
    private String name;
    private String course_code;
    private String admin_id;
} // end class

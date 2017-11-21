package org.zerock.domain;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class BoardVO {

	private Integer bno;

	private String title;

	private String content;

	private String writer;

	private Date regdate;
	private int viewcnt;
	private int replycnt;

	private String[] files;
}

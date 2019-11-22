package com.acorn.team1.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.acorn.team1.domain.FileVO;
import com.acorn.team1.persistence.FileDAO;

@Service
public class FileServiceImpl implements FileService {

	@Inject
	private FileDAO dao;
	@Override
	public FileVO searchFile_info(int file_id) {
		
		return dao.file_info(file_id);
	}

}

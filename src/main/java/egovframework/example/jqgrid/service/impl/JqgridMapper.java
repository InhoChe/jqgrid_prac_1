package egovframework.example.jqgrid.service.impl;

import java.util.List;
import java.util.Map;

//import org.json.JSONArray;

import egovframework.example.jqgrid.service.JqgridVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
@Mapper("jqgridMapper")
public interface JqgridMapper {

	List<EgovMap> selectJqgridList(Map<String, Object> jqgridMap);

	EgovMap selectJqgridListCnt(Map<String, Object> jqgridMap);

	List<EgovMap> selectJqgridList2(JqgridVO jqgridVO);

	EgovMap selectJqgridListCnt2(JqgridVO jqgridVO);

	void insertJqgridList(Map<String, Object> param);

	void updateJqgridList(Map<String, Object> param);
	
	void deleteJqgridList(Map<String, Object> param);
	
	List<EgovMap> selectBrandCombo(Map<String, Object> param);

	List<EgovMap> selectBrandList(Map<String, Object> paramMap);

	EgovMap selectBrandListCnt(Map<String, Object> paramMap);

	void insertBrand(Map<String, Object> param);

	void updateBrand(Map<String, Object> param);

	List<EgovMap> selectPrdList(Map<String, Object> paramMap);

	EgovMap selectPrdListCnt(Map<String, Object> paramMap);

	void insertPrd(Map<String, Object> param);

	void updatePrd(Map<String, Object> param);
	
}

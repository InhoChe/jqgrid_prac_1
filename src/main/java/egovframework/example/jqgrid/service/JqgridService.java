package egovframework.example.jqgrid.service;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface JqgridService {

	List<EgovMap> selectJqgridList(Map<String, Object> jqgridMap) throws Exception;

	EgovMap selectJqgridListCnt(Map<String, Object> jqgridMap)throws Exception;

	List<EgovMap> selectJqgridList(JqgridVO jqgridVO) throws Exception;

	EgovMap selectJqgridListCnt(JqgridVO jqgridVO) throws Exception;

	void saveJqgridTx(JSONArray jsonArray) throws Exception;

	List<EgovMap> selectBrandCombo(Map<String, Object> param);

	List<EgovMap> selectBrandList(Map<String, Object> paramMap);

	EgovMap selectBrandListCnt(Map<String, Object> paramMap);

	void saveBrandTx(JSONArray jsonArray) throws Exception;
	
	void deleteJqgridTx(JSONArray jsonArray) throws Exception;
	
	List<EgovMap> selectPrdList(Map<String, Object> paramMap);

	EgovMap selectPrdListCnt(Map<String, Object> paramMap);

	void savePrdTx(JSONArray jsonArray);
	
}

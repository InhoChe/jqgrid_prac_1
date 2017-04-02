package egovframework.example.jqgrid.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.*;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.jqgrid.service.JqgridService;
import egovframework.example.jqgrid.service.JqgridVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
@Service("jqgridService")
public class JqgridServiceImpl extends EgovAbstractServiceImpl implements JqgridService {
	
	@Resource(name = "jqgridMapper")
	private JqgridMapper jqgridMapper;
	
	@Override
	public List<EgovMap> selectJqgridList(Map<String, Object> jqgridMap) {
		return jqgridMapper.selectJqgridList(jqgridMap);
	}

	@Override
	public EgovMap selectJqgridListCnt(Map<String, Object> jqgridMap) {
		return jqgridMapper.selectJqgridListCnt(jqgridMap);
	}
	
	@Override
	public List<EgovMap> selectJqgridList(JqgridVO jqgridVO) throws Exception {
		return jqgridMapper.selectJqgridList2(jqgridVO);
	}

	@Override
	public EgovMap selectJqgridListCnt(JqgridVO jqgridVO) throws Exception {
		return jqgridMapper.selectJqgridListCnt2(jqgridVO);
	}

	@Override
	public void saveJqgridTx(JSONArray jsonArray) throws Exception {
		
		int iLength1 = jsonArray.length();
		System.out.println("-------->"+iLength1);
		try{
			for(int i = 0; i < iLength1; i++){
				
				org.json.JSONObject jsonObject = jsonArray.getJSONObject(i);
				
				Map<String, Object> param = JsonUtil.JsonToMap(jsonObject.toString());
				System.out.println("-------->"+param.get("editType"));
				if("I".equals(param.get("editType"))){
					jqgridMapper.insertJqgridList(param);
				}else if("U".equals(param.get("editType"))){
					jqgridMapper.updateJqgridList(param);
				}
			}
		} catch(Exception ex){
			throw ex;
		}
		
	}
	
	@Override
	public void deleteJqgridTx(JSONArray jsonArray) {
		int iLength1 = jsonArray.length();
		System.out.println("-------->"+iLength1);
		try{
			for(int i = 0; i < iLength1; i++){
				
				org.json.JSONObject jsonObject = jsonArray.getJSONObject(i);
				
				Map<String, Object> param = JsonUtil.JsonToMap(jsonObject.toString());
				jqgridMapper.deleteJqgridList(param);
			}
		} catch(Exception ex){
			throw ex;
		}
	}
	
	@Override
	public List<EgovMap> selectBrandCombo(Map<String, Object> param) {
		
		return jqgridMapper.selectBrandCombo(param);
	}

	@Override
	public List<EgovMap> selectBrandList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return jqgridMapper.selectBrandList(paramMap);
	}

	@Override
	public EgovMap selectBrandListCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return jqgridMapper.selectBrandListCnt(paramMap);
	}

	@Override
	public void saveBrandTx(JSONArray jsonArray) throws Exception {

		int iLength1 = jsonArray.length();
	
		        try {
		        
		            for(int i=0; i<iLength1; i++) {
		            
		                JSONObject jsonObject = jsonArray.getJSONObject(i);
	
		                Map<String, Object> param = JsonUtil.JsonToMap(jsonObject.toString());
		                
		                if("I".equals(param.get("editType"))) {
	
		                jqgridMapper.insertBrand(param);
		                }else if("U".equals(param.get("editType"))) {
		                
		                jqgridMapper.updateBrand(param);
		                }
		            }
		} catch (Exception ex) {
	
		            throw ex;
		}        
	}
	
	@Override
	public List<EgovMap> selectPrdList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return jqgridMapper.selectPrdList(paramMap);
	}

	@Override
	public EgovMap selectPrdListCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return jqgridMapper.selectPrdListCnt(paramMap);
	}

	@Override
	public void savePrdTx(JSONArray jsonArray) {
		// TODO Auto-generated method stub
		int iLength1 = jsonArray.length();
		
        try {
        
            for(int i=0; i<iLength1; i++) {
            
                JSONObject jsonObject = jsonArray.getJSONObject(i);

                Map<String, Object> param = JsonUtil.JsonToMap(jsonObject.toString());
                
                if("I".equals(param.get("editType"))) {

                jqgridMapper.insertPrd(param);
                }else if("U".equals(param.get("editType"))) {
                
                jqgridMapper.updatePrd(param);
                }
            }
		} catch (Exception ex) {
		
		    throw ex;
		}
	}

}

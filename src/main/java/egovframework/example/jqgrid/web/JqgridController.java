package egovframework.example.jqgrid.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.jqgrid.service.JqgridService;
import egovframework.example.jqgrid.service.JqgridVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class JqgridController {
	
	@Resource(name = "jqgridService")
	private JqgridService jqgridService;
	
	@RequestMapping(value = "jqgridStart.do")
	public String jqgridStart() throws Exception {

		return "jqgrid/jqgridStart";
	}
	
	@RequestMapping(value = "jqgridIUD.do")
	public String jqgridIUD() throws Exception {

		return "jqgrid/jqgridIUD";
	}
	
	@RequestMapping(value = "jqgridM.do")
	public String jqgridM() throws Exception {

		return "jqgrid/jqgridM";
	}
	
	@RequestMapping(value = "jqgridGroupReport.do")
	public String jqgridGroupReport(ModelMap model) throws Exception {
		// 조회용 브랜드 리스트 콤보
				Map<String, Object> param = new HashMap<String, Object>();
				
				List<EgovMap> brandList =jqgridService.selectBrandCombo(param);
				
				model.addAttribute("brandList", brandList);
				
				if(brandList.size() > 0){
					
					// POM
					JSONObject jsonObj = new JSONObject();
					
					for(int i = 0; i < brandList.size(); i++){
															//key							//value
						jsonObj.put((String)brandList.get(i).get("brandCd"), brandList.get(i).get("brandNm"));
					}
					
					model.addAttribute("brandCombo", jsonObj);
				}
		return "jqgrid/jqgridGroupReport";
	}
	
	@RequestMapping(value = "/brandList.do")
	public void brandList(HttpServletRequest request,
	HttpServletResponse response,
	@RequestParam(required=false) String param,
	@RequestParam(required=false) String rows,
	@RequestParam(required=false) String page,
	ModelMap model) throws Exception {

	PrintWriter out = null;
	response.setCharacterEncoding("UTF-8");
	param = param.replaceAll("&quot;", "\"");

	Map<String, Object> paramMap = new HashMap<String, Object>();

	paramMap = JsonUtil.JsonToMap(param);
	paramMap.put("rows", rows);
	paramMap.put("page", page);

	List<EgovMap> brandList = jqgridService.selectBrandList(paramMap);

	EgovMap brandListCnt = jqgridService.selectBrandListCnt(paramMap);

	HashMap<String, Object> resMap = new HashMap<String, Object>();

	resMap.put("records", brandListCnt.get("totalTotCnt"));            
	        resMap.put("rows",    brandList);
	        resMap.put("page",    page);
	        resMap.put("total",   brandListCnt.get("totalPage"));

	out = response.getWriter();

	out.write(JsonUtil.HashMapToJson(resMap).toString());
	}

	@RequestMapping(value = "/saveBrand.do")
	public @ResponseBody String saveBrand(@RequestParam String param1) throws Exception {

	String result = "";

	try {
		param1 = param1.replaceAll("&quot;", "\"");

	    JSONArray jsonArray = new JSONArray(param1);
	    
	    jqgridService.saveBrandTx(jsonArray);

	    result = "SUCCESS";
	} catch (Exception e) {
		result = "FAIL";
	}
	return  result;
	}
	
	
	
	@RequestMapping(value = "/prdList.do")
	public void prdList(HttpServletRequest request,
	HttpServletResponse response,
	@RequestParam(required=false) String param,
	@RequestParam(required=false) String rows,
	@RequestParam(required=false) String page,
	ModelMap model) throws Exception {

	PrintWriter out = null;
	response.setCharacterEncoding("UTF-8");

	param = param.replaceAll("&quot;", "\"");

	Map<String, Object> paramMap = new HashMap<String, Object>();

	paramMap = JsonUtil.JsonToMap(param);
	paramMap.put("rows", rows);
	paramMap.put("page", page);

	List<EgovMap> prdList = jqgridService.selectPrdList(paramMap);

	EgovMap prdListCnt = jqgridService.selectPrdListCnt(paramMap);

	HashMap<String, Object> resMap = new HashMap<String, Object>();

	resMap.put("records", prdListCnt.get("totalTotCnt"));            
	        resMap.put("rows",    prdList);
	        resMap.put("page",    request.getParameter("page"));
	        resMap.put("total",   prdListCnt.get("totalPage"));

	out = response.getWriter();

	out.write(JsonUtil.HashMapToJson(resMap).toString());
	}

	
	@RequestMapping(value = "/savePrd.do")
	public @ResponseBody String savePrd(@RequestParam String param1) throws Exception {

	String result = "";

	try {
		System.out.println("1.param1 ===> " + param1);
		param1 = param1.replaceAll("&quot;", "\"");
		System.out.println("2.param1 ===> " + param1);
	    JSONArray jsonArray = new JSONArray(param1);
	        
	    jqgridService.savePrdTx(jsonArray);

	    result = "SUCCESS";

	} catch (Exception e) {
		result = "FAIL";
	}
	    return  result;
	}
	
	
	
	@RequestMapping(value = "/saveJqgrid.do")   
    public @ResponseBody String saveJqgrid(@RequestParam String param1) throws Exception {

       String result = "";
       System.out.println("========>"+param1);
       try {
          param1 = param1.replaceAll("&quot;", "\"");
          
            JSONArray jsonArray = new JSONArray(param1);
            
            jqgridService.saveJqgridTx(jsonArray);

          result = "SUCCESS";

       } catch (Exception e) {
          
          result = "FAIL";
       }

        return result;
    }
	
	@RequestMapping(value = "/deleteJqgrid.do")   
    public @ResponseBody String deleteJqgrid(@RequestParam String param1) throws Exception {

       String result = "";
       System.out.println("========>"+param1);
       try {
          param1 = param1.replaceAll("&quot;", "\"");
          
            JSONArray jsonArray = new JSONArray(param1);
            
            jqgridService.deleteJqgridTx(jsonArray);

          result = "SUCCESS";

       } catch (Exception e) {
          
          result = "FAIL";
       }

        return result;
    }
	
	@RequestMapping(value = "jqgridStartMain.do")
	   public void jqgridStartMain(HttpServletRequest request,
	         HttpServletResponse response,
	         @ModelAttribute JqgridVO jqgridVO, ModelMap model) throws Exception {

	      PrintWriter out = null;
	      
	      response.setCharacterEncoding("UTF-8");

	      String quotZero = request.getParameter("param");
	      System.out.println("1. "+quotZero);
	      quotZero = quotZero.replaceAll("&quot;", "\"");
	      System.out.println("2. "+quotZero);
	      Map<String, Object> castMap = new HashMap<String, Object>();
	      
	      castMap = JsonUtil.JsonToMap(quotZero);
	      
	      jqgridVO.setServiceImplYn((String) castMap.get("serviceImplYn"));
	      
	      List<EgovMap> jqGridList = jqgridService.selectJqgridList(jqgridVO);
	      
	      EgovMap jqGridListCnt = jqgridService.selectJqgridListCnt(jqgridVO);

	      HashMap<String, Object> resMap = new HashMap<String, Object>();
	      
	      resMap.put("records", jqGridListCnt.get("totaltotcnt"));            
	      resMap.put("rows",    jqGridList);
	      resMap.put("page",    request.getParameter("page"));
	      resMap.put("total",   jqGridListCnt.get("totalpage"));
	      
	      out = response.getWriter();
	      System.out.println("3. "+JsonUtil.HashMapToJson(resMap).toString());
	      out.write(JsonUtil.HashMapToJson(resMap).toString());
	   }
	
	@RequestMapping(value = "jqgridStartMain2.do")
	   public void jqgridStartMain2(HttpServletRequest request,
	         HttpServletResponse response,
	         ModelMap model) throws Exception {

	      PrintWriter out = null;
	      
	      response.setCharacterEncoding("UTF-8");

	      String quotZero = request.getParameter("param");
	      System.out.println("1. "+quotZero);
	      quotZero = quotZero.replaceAll("&quot;", "\""); // \" -> 이스케이프 + " 해야 더블쿼테이션을 문자로 붙일 수 있음.
	      System.out.println("2. "+quotZero);
	      Map<String, Object> castMap = new HashMap<String, Object>();
	      
	      Map<String, Object> jqgridMap = new HashMap<String, Object>();
	      
	      castMap = JsonUtil.JsonToMap(quotZero);	// GSON pom.xml에 추가한 이유  (JsonUtil 안에 GSON 클래스 사용함)
	      jqgridMap.put("serviceImplYn", castMap.get("serviceImplYn"));
	      jqgridMap.put("rows", request.getParameter("rows"));
	      jqgridMap.put("page", request.getParameter("page"));
	      
	      List<EgovMap> jqGridList = jqgridService.selectJqgridList(jqgridMap);
	      
	      EgovMap jqGridListCnt = jqgridService.selectJqgridListCnt(jqgridMap);

	      HashMap<String, Object> resMap = new HashMap<String, Object>();
	      
	      resMap.put("records", jqGridListCnt.get("totaltotcnt"));            
	      resMap.put("rows",    jqGridList);
	      resMap.put("page",    request.getParameter("page"));
	      resMap.put("total",   jqGridListCnt.get("totalpage"));
	      
	      out = response.getWriter();
	      System.out.println("3. "+JsonUtil.HashMapToJson(resMap).toString());
	      out.write(JsonUtil.HashMapToJson(resMap).toString());
	   }
}

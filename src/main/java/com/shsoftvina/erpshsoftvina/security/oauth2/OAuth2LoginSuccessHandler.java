//package com.shsoftvina.erpshsoftvina.security.oauth2;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
//import org.springframework.stereotype.Component;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//@Component
//public class OAuth2LoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
//
////    @Autowired
////    private UserService userService;
//
//    @Override
//    public void onAuthenticationSuccess(HttpServletRequest request,
//                                        HttpServletResponse response,
//                                        Authentication authentication)
//            throws IOException, ServletException {
//
//        System.out.println("login success");
//
////        CustomOAuth2User oAuth2User = (CustomOAuth2User) authentication.getPrincipal();
////        String loginName = oAuth2User.getLogin();
////        String displayName = oAuth2User.getFullname();
////
////        User user = userService.findByEmail(loginName);
////        if (user == null){
////            userService.registerNewUserAfterOAuthLoginSuccess(loginName, displayName,
////                    AuthenticationProvider.GITHUB);
////        }else{
////            userService.updateExistingUser(user, displayName, AuthenticationProvider.GITHUB);
////        }
//    }
//}

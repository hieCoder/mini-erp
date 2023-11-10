package com.shsoftvina.erpshsoftvina.security.oauth2;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.exception.NotFoundException;
import com.shsoftvina.erpshsoftvina.exception.UserLockException;
import com.shsoftvina.erpshsoftvina.exception.UserPendingException;
import com.shsoftvina.erpshsoftvina.exception.WaitingApprovalException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.service.AuthService;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AuthService authService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest);

        String email = (String) oAuth2User.getAttributes().get("email");
        if(email == null) throw new NotFoundException(MessageErrorUtils.notFound("email"));
        User user = userMapper.findByEmail(email);

        if(user == null){
            authService.registerUserOAuth2(oAuth2User);
            throw new WaitingApprovalException("Waiting approval");
        } else{
            if(user.getStatus().equals(StatusUserEnum.INACTIVE)){
                throw new UserLockException("User is lock");
            } else if(user.getStatus().equals(StatusUserEnum.PENDING)){
                throw new UserPendingException("User is pending");
            } else{
                user.setUser(oAuth2User);
                return user;
            }
        }
    }
}

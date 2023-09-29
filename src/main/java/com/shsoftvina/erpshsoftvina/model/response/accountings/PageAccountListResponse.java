package com.shsoftvina.erpshsoftvina.model.response.accountings;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PageAccountListResponse {
    List<AccountResponse> accountResponseList;
    long pageNumber;
    long totalPages;
    Boolean hasNext;
    Boolean hasPrevious;

}

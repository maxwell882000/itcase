import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:itcase/app/models/comments.dart';
import 'package:itcase/app/models/e_service_model.dart';
import 'package:itcase/app/models/review_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/providers/mock_provider.dart';



class EServiceRepository {
  MockApiClient _apiClient;

  EServiceRepository() {
    this._apiClient = MockApiClient(httpClient: Dio());
  }

  Future<List<Comments>> getComments(String id)async{
    final response = await API().getData('contractors/comment/$id');
    print(response.body);
    if (response.statusCode ==200){
      Map body = jsonDecode(response.body);
      return body['comments'].map<Comments>((e)=>Comments.fromJson(e)).toList();
    }
    throw response.body;
  }

  Future<Map> createComments(String json)async{
    final response = await API().post(json, "contractors/comment");
    print(response.body);
    if (response.statusCode ==200){
      Map body = jsonDecode(response.body);
      return body;
    }
    throw response.body;
  }

  Future<List<Tenders>> getShortTenderOfUser({String id}) async{
    final response = await API().getData("account/myTenders/short/$id");
    print("GET SHORT");
    print(response.body);
    if(response.statusCode == 200){
      Map body = jsonDecode(response.body);
      return body['tenders'].map<Tenders>((e)=> new Tenders.fromJsonShort(e)).toList();
    }
    print(response.body);
    throw "shortTenderOfUser";
  }

  Future<Map> inviteContractor({String contractorId , String tenderId}) async{
    print("URL ");
    print("contractors/addContractor/$contractorId/to/$tenderId");
    final response = await API().getData("contractors/addContractor/$contractorId/to/$tenderId");
    print(response.body);
    if(response.statusCode == 200){
      Map body = jsonDecode(response.body);
      return body;
    }
    print(response.body);
    throw "inviteContractor";
  }

  Future<List<User>> getAll(String id) {
    return _apiClient.getAllEServices(id);
  }
  Future<List<User>> getAllCategories(String id) {
    return _apiClient.getAllEServices(id);
  }
  Future<User> get(String id){
    return _apiClient.getEService(id);
  }

  Future<List<EService>> getFavorites() {
    return _apiClient.getFavoritesEServices();
  }

  Future<List<EService>> getRecommended() {
    return _apiClient.getRecommendedEServices();
  }

  Future<List<EService>> getFeatured() {
    return _apiClient.getFeaturedEServices();
  }

  Future<List<EService>> getPopular() {
    return _apiClient.getPopularEServices();
  }

  Future<List<EService>> getMostRated() {
    return _apiClient.getMostRatedEServices();
  }

  Future<List<EService>> getAvailable() {
    return _apiClient.getAvailableEServices();
  }


  Future<List<Review>> getReviews(String eServiceId) {
    return _apiClient.getEServiceReviews(eServiceId);
  }
}
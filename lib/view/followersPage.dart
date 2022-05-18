import 'package:flutter/material.dart';
import 'package:github_search/Model/followersModel.dart';
import 'package:github_search/Controller/request.dart';
import 'package:github_search/Component/userPageComponent.dart';

class FollowersPage extends StatefulWidget {
  final String username;
  const FollowersPage({Key? key, required this.username}) : super(key: key);

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub User", style: TextStyle(color: Colors.white)),
      ),
      body: _buildDetailRepoBody(),
    );
  }

  Widget _buildDetailRepoBody() {
    return FutureBuilder<List<FollowersModel>>(
        future: UserDataSource.instance.loadUsersFollowers(widget.username),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // return Card();
            return _buildSuccessSection(snapshot);
          }
          return _buildLoadingSection();
        });
  }


  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(AsyncSnapshot<List<FollowersModel>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _repoPage("${snapshot.data![index].login}");
      },
    );
  }

  Widget _repoPage(String temp){
    if(temp == "null"){
      return Center(child: Text('User Not Found'),);
    }
    else {
      return Center(child: Text(temp),);
    }
  }
}
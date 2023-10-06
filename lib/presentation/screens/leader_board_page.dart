import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  final List<Player> players = [
    Player(name: 'John Doe', score: 150, level: 5),
    Player(name: 'Alice Smith', score: 120, level: 4),
    Player(name: 'Bob Johnson', score: 100, level: 3),
  ];

  LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLeaderboardTitle(),
            const SizedBox(height: 16.0),
            _buildLeaderboardList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardTitle() {
    return const Text(
      'Classement',
      style: AppTextStyles.subtitle,
    );
  }

  Widget _buildLeaderboardList() {
    return Expanded(
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return _buildLeaderboardItem(player, index + 1);
        },
      ),
    );
  }

  Widget _buildLeaderboardItem(Player player, int rank) {
    final isTopThree = rank <= 3;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isTopThree ? Colors.yellowAccent : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$rank. ${player.name}',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Score: ${player.score} - Level: ${player.level}',
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

class Player {
  final String name;
  final int score;
  final int level;

  Player({required this.name, required this.score, required this.level});
}

import 'package:flame_game/presentation/controllers/evolution_controller.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../domain/entities/player.dart';

class LeaderboardPage extends StatelessWidget {
  LeaderboardPage({super.key});
  EvolutionController evolutionController = Get.find();

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
    return Text(
      'Classement',
      style: AppTextStyles.subtitle.copyWith(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLeaderboardList() {
    return Expanded(
        child: GetBuilder<EvolutionController>(
            didUpdateWidget: (oldWidget, state) =>
                evolutionController.getRanking(),
            builder: (_) {
              return Obx(() {
                final players = evolutionController.players;
                return players.isEmpty
                    ? const CircularProgressIndicator(
                        color: Colors.yellow,
                      )
                    : ListView.builder(
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          final player = players[index];
                          return _buildLeaderboardItem(player, index + 1);
                        },
                      );
              });
            }));
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${rank == 1 ? '🏆 $rank' : rank}. ${player.userName}',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${player.totalScore} pts',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

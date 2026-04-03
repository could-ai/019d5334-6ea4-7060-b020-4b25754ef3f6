import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/log_provider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/data_table_widget.dart';
import '../services/api_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with TickerProviderStateMixin {
  late TabController _tabController;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final logProvider = Provider.of<LogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logProvider.addLog('Admin logged out');
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Generate Access'),
            Tab(text: 'Transaction Status'),
            Tab(text: 'Clearing Status'),
            Tab(text: 'PayOut Details'),
            Tab(text: 'PayOut Summary'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGenerateAccessTab(),
          _buildTransactionStatusTab(),
          _buildClearingStatusTab(),
          _buildPayoutDetailsTab(),
          _buildPayoutSummaryTab(),
        ],
      ),
    );
  }

  Widget _buildGenerateAccessTab() {
    // Generate Access tab for creating users
    return const Center(child: Text('Generate Access Tab - Coming Soon'));
  }

  Widget _buildTransactionStatusTab() {
    return Column(
      children: [
        SearchBarWidget(
          onSearch: (params) async {
            try {
              final data = await _apiService.getTransactionStatus(
                status: params['status'],
                startDate: params['startDate'],
                endDate: params['endDate'],
                mid: params['mid'],
                tid: params['tid'],
                rrn: params['rrn'],
                name: params['name'],
              );
              return data;
            } catch (e) {
              return [];
            }
          },
          fields: const ['status', 'dateRange', 'mid', 'tid', 'rrn', 'name'],
        ),
        const Expanded(child: DataTableWidget()),
      ],
    );
  }

  Widget _buildClearingStatusTab() {
    return Column(
      children: [
        SearchBarWidget(
          onSearch: (params) async {
            try {
              final data = await _apiService.getClearingStatus(
                startDate: params['startDate'],
                endDate: params['endDate'],
                mid: params['mid'],
                tid: params['tid'],
                rrn: params['rrn'],
                name: params['name'],
              );
              return data;
            } catch (e) {
              return [];
            }
          },
          fields: const ['dateRange', 'mid', 'tid', 'rrn', 'name'],
        ),
        const Expanded(child: DataTableWidget()),
      ],
    );
  }

  Widget _buildPayoutDetailsTab() {
    return Column(
      children: [
        SearchBarWidget(
          onSearch: (params) async {
            try {
              final data = await _apiService.getPayoutDetails(
                startDate: params['startDate'],
                endDate: params['endDate'],
                aggregatorCode: params['aggregatorCode'],
                mid: params['mid'],
                terminalId: params['terminalId'],
                rrn: params['rrn'],
                stan: params['stan'],
                authCode: params['authCode'],
              );
              return data;
            } catch (e) {
              return [];
            }
          },
          fields: const ['dateRange', 'aggregatorCode', 'mid', 'terminalId', 'rrn', 'stan', 'authCode'],
        ),
        const Expanded(child: DataTableWidget()),
      ],
    );
  }

  Widget _buildPayoutSummaryTab() {
    return Column(
      children: [
        SearchBarWidget(
          onSearch: (params) async {
            try {
              final data = await _apiService.getPayoutSummary(
                startDate: params['startDate'],
                endDate: params['endDate'],
                aggregatorCode: params['aggregatorCode'],
                mid: params['mid'],
                legalName: params['legalName'],
                displayName: params['displayName'],
              );
              return data;
            } catch (e) {
              return [];
            }
          },
          fields: const ['dateRange', 'aggregatorCode', 'mid', 'legalName', 'displayName'],
        ),
        const Expanded(child: DataTableWidget()),
      ],
    );
  }
}
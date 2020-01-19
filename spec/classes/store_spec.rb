require 'spec_helper'

describe 'thanos::store' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          bin_path: '/usr/local/bin/thanos',
        }
      end

      it {
        is_expected.to compile
      }

      it {
        is_expected.to contain_thanos__resources__service('store').with(
          'ensure'   => 'running',
          'bin_path' => '/usr/local/bin/thanos',
          'params'   => {
            'log.level'                         => 'info',
            'log.format'                        => 'logfmt',
            'tracing.config-file'               => nil,
            'http-address'                      => '0.0.0.0:10902',
            'http-grace-period'                 => '2m',
            'grpc-address'                      => '0.0.0.0:10901',
            'grpc-grace-period'                 => '2m',
            'grpc-server-tls-cert'              => nil,
            'grpc-server-tls-key'               => nil,
            'grpc-server-tls-client-ca'         => nil,
            'data-dir'                          => nil,
            'index-cache-size'                  => '250MB',
            'chunk-pool-size'                   => '2GB',
            'store.grpc.series-sample-limit'    => 0,
            'store.grpc.series-max-concurrency' => 20,
            'objstore.config-file'              => nil,
            'sync-block-duration'               => '3m',
            'block-sync-concurrency'            => 20,
            'min-time'                          => nil,
            'max-time'                          => nil,
            'selector.relabel-config-file'      => nil,
          },
        )
      }
    end
  end
end
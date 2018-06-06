Shader "Unlit/Sphere Texture" {
	Properties {
		_MainTex("Texture", 2D) = "white" {}
		_Tiling("Tiling", Float) = 6
		_Speed("Speed", Float) = 1.25
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			float _Tiling;
			float _Speed;
			float4 _MainTex_ST;
			sampler2D _MainTex;
			
			v2f vert(appdata v) {
				v2f o;
								
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target {
				fixed4 col = tex2D(_MainTex, _MainTex_ST.xy * i.uv * _Tiling + _Speed * _Time);
				return col;
			}
			ENDCG
		}
	}
}

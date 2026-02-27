/**
 * 语言管理
 * 由于 Figma 插件环境，使用简单的状态管理而非 Context
 */
import { Locale, TranslationMessages, LocaleConfig } from './types'
import { zhCN } from './locales/zh-CN'
import { enUS } from './locales/en-US'

/** 语言翻译映射 */
export const translations: Record<Locale, TranslationMessages> = {
  'zh-CN': zhCN,
  'en-US': enUS
}

/** 语言配置列表 */
export const LOCALE_CONFIGS: LocaleConfig[] = [
  { label: '中文', value: 'zh-CN' },
  { label: 'English', value: 'en-US' }
]

/** 获取翻译文本 */
export function getTranslation(locale: Locale): TranslationMessages {
  return translations[locale] || zhCN
}

/** 占位符常量（用于 generateExportName 返回值判断） */
export const PLACEHOLDERS = {
  SELECT_NAME_FUNCTION: '__SELECT_NAME_FUNCTION__',
  SELECT_LAYERS_FIRST: '__SELECT_LAYERS_FIRST__'
}
